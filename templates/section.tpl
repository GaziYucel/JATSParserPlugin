{**
 * plugins/generic/jatsParser/templates/section.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A template to be included via Templates::Article::Main hook.
 * for displaying content  of article sections
 *}


{if get_class($secCont) == "ParContent" && $secCont->getType() == "paragraph"}{strip}
    <p class="for-sections">
        {foreach from=$secCont item=parCont}
            {include file="`$path_template`/paragraph.tpl"}
        {/foreach}
    </p>
{/strip}{elseif get_class($secCont) == "JatsList" && ($secCont->getType() =="list-ordered" || $secCont->getType() == "list-unordered")}{strip}
    {if $secCont->getType() == "list-ordered"}
        <ol class="ordered-1">
            {foreach from=$secCont->getContent() item=jatsList}
                <li class="in-ordered">
                    <p class="inlist">
                        {foreach from=$jatsList->getContent() item=parCont}
                            {include file="`$path_template`/paragraph.tpl"}
                            {include file="`$path_template`/list.tpl"}
                        {/foreach}
                    </p>
                </li>
            {/foreach}
        </ol>
    {elseif $secCont->getType() == "list-unordered"}
        <ol class="unordered-1">
            {foreach from=$secCont->getContent() item=jatsList}
                <li class="in-ordered">
                    <p class="inlist">
                        {foreach from=$jatsList->getContent() item=parCont}
                            {include file="`$path_template`/paragraph.tpl"}
                            {include file="`$path_template`/list.tpl"}
                        {/foreach}
                    </p>
                </li>
            {/foreach}
        </ol>
    {/if}
{/strip}{elseif get_class($secCont) == "Table"}
    <div class="figure-wrap table">
        <div class="fig-box" id="{$secCont->getId()}">
            <table>
                {foreach from=$secCont->getContent() item=tableTitles}
                    {if $tableTitles->getType() == "table-title"}
                        <caption class="table-title">
                            <strong>{$secCont->getLabel()}</strong>
                            {foreach from=$tableTitles->getContent() item=parCont}
                                {include file="`$path_template`/paragraph.tpl"}
                            {/foreach}
                        </caption>
                    {/if}
                {/foreach}

                {** capture group for adding inside thead*}
                {capture name="insideTableHead"}
                    {foreach from=$secCont->getContent() item=row}
                        {if $row->getType() == "head"}
                            <tr>
                                {foreach from=$row->getContent() item=cell}
                                    <th colspan="{$cell->getColspan()}" rowspan="{$cell->getRowspan()}">
                                        {foreach from=$cell->getContent() item=parCont}
                                            {include file="`$path_template`/paragraph.tpl"}
                                        {/foreach}
                                    </th>
                                {/foreach}
                            </tr>
                        {/if}
                    {/foreach}
                {/capture}


                <thead>
                {$smarty.capture.insideTableHead}
                </thead>

                {** capture group for adding inside tbody*}
                {capture name="insideTableBody"}
                    {foreach from=$secCont->getContent() item=row}
                        {if $row->getType() == "body"}
                            <tr>
                                {foreach from=$row->getContent() item=cell}
                                    <td colspan="{$cell->getColspan()}" rowspan="{$cell->getRowspan()}">
                                        {foreach from=$cell->getContent() item=parCont}
                                            {include file="`$path_template`/paragraph.tpl"}
                                        {/foreach}
                                    </td>
                                {/foreach}
                            </tr>
                        {/if}
                    {/foreach}
                {/capture}

                <tbody>
                {$smarty.capture.insideTableBody}
                </tbody>

                {** for flat tables *}
                {capture name="insideTableFlat"}
                    {foreach from=$secCont->getContent() item=row}
                        {if $row->getType() == "flat"}
                            <tr>
                                {foreach from=$row->getContent() item=cell}
                                    <th colspan="{$cell->getColspan()}" rowspan="{$cell->getRowspan()}">
                                        {foreach from=$cell->getContent() item=parCont}
                                            {include file="`$path_template`/paragraph.tpl"}
                                        {/foreach}
                                    </th>
                                {/foreach}
                            </tr>
                        {/if}
                    {/foreach}
                {/capture}
                {$smarty.capture.insideTableFlat}
            </table>

            {foreach from=$secCont->getContent() item=tableCaption}
                {if $tableCaption->getType() == "table-caption"}
                    <p class="comments">
                        {foreach from=$tableCaption->getContent() item=parCont}
                            {include file="`$path_template`/paragraph.tpl"}
                        {/foreach}
                    </p>
                {/if}
            {/foreach}
        </div>
    </div>
{elseif get_class($secCont) == "Figure"}
    <div class="figure-wrap fig">
        <div class="{$secCont->getId()}">
            {strip}
                {if $secCont->getLabel() != NULL}
                    <strong>{$secCont->getLabel()}</strong>
                    <p class="figure-title">
                        {foreach from=$secCont->getContent() item=figurePars}
                            {if $figurePars->getType() == "figure-title"}
                                {foreach from=$figurePars item=parCont}
                                    {include file="`$path_template`/paragraph.tpl"}
                                {/foreach}
                            {/if}
                        {/foreach}
                    </p>
                {/if}
            {/strip}
            <div class="imagewrap">
                <img src="{$secCont->getLink()}">
            </div>

            {capture name="figureComments"}
                {foreach from=$secCont->getContent() item=figureCaptionPars}
                    {if $figureCaptionPars->getType() == "figure-caption"}
                        <p class="comments">
                            {foreach from=$figureCaptionPars item=parCont}
                                {include file="`$path_template`/paragraph.tpl"}
                            {/foreach}
                        </p>
                    {/if}
                {/foreach}
            {/capture}

            <div class="figure-comments">
                {$smarty.capture.figureComments}
            </div>
        </div>
    </div>
{/if}