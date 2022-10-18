{$meta_title="Прикрепленные документы" scope=parent}

{capture name='page_scripts'}

<script src="theme/site/js/account_docs.app.js"></script>

{/capture}

{capture name='page_styles'}
    
{/capture}


<main class="main">
  <div class="section_lk_navbar">
    <div class="container">
      <nav class="navbar lk_menu">
        <ul class="nav lk_menu_nav -gil-m">
          <li class="nav-item">
            <a class="nav-link" href="account">Общая информация</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="account/history">История займов</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="account/cards">Банковские карты</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="account/data">Личные данные</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="account/docs">Документы</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-danger" href="lk/logout">Выйти</a>
          </li>
        </ul>
      </nav>
    </div>
  </div>
  <div class="content_wrap">
    <div class="container">
      <h1>Личный кабинет</h1>
      
      <!-- общая информация -->
      <div class="person_info_box">
        <div class="person_info -gil-m">
          
          {if !$card->id}
          <div class="person_info_title -fs-26">Список прикрепленных документов</div>
          <div class="person_info_wrap -fs-18">
            <div class="row">
                <div class="col-md-6"> 
                    <ul class="docs_list js-docs-list">
                      
                      {if $files['passport1']}  
                      <li class="docs_list_item">
                        <a href="{$config->user_files_dir}{$files['passport1']->name}" class="docs_list_link" data-fancybox>Скан паспорта</a>
                      </li>
                      {/if}
                      {if $files['passport2']}  
                      <li class="docs_list_item">
                        <a href="{$config->user_files_dir}{$files['passport2']->name}" class="docs_list_link" data-fancybox>Скан паспорта с регистрацией</a>
                      </li>
                      {/if}
                      {if $files['face']}  
                      <li class="docs_list_item">
                        <a href="{$config->user_files_dir}{$files['face']->name}" class="docs_list_link" data-fancybox>Фото с разворотом паспорта</a>
                      </li>
                      {/if} 
                      {if $files['card']}  
                      <li class="docs_list_item">
                        <a href="{$config->user_files_dir}{$files['card']->name}" class="docs_list_link" data-fancybox>Фото карты</a>
                      </li>
                      {/if} 
                      
                      {if $other_files}
                      {foreach $other_files as $ofile}
                      <li class="docs_list_item">
                        <a href="{$config->user_files_dir}{$ofile->name}" class="docs_list_link" data-fancybox>Документ</a>
                      </li>
                      {/foreach}
                      {/if}
                      {*}
                      <li class="docs_list_item">
                        <a href="#" class="docs_list_link" data-fancybox>СНИЛС</a>
                      </li>
                      <li class="docs_list_item"><a href="#" class="docs_list_link" data-fancybox>Договор №1232-125215</a>
                      </li>
                      {*}
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="docs_list">
                      {foreach $documents as $document}
                      <li class="docs_list_item">
                        <a href="{$config->root_url}/document/{$user->id}/{$document->id}" class="docs_list_link" target="_blank">
                            {$document->name|escape}
                        </a>
                      </li>
                      {/foreach}
                      {foreach $receipts as $receipt}
                      <li class="docs_list_item">
                        <a href="{$receipt->receipt_url}" class="docs_list_link" target="_blank">
                            Кассовый чек от {$receipt->created|date}
                        </a>
                      </li>
                      {/foreach}
                    </ul>
                </div>
            </div>
          </div>
          {/if}
          
          {if $card->id}
          <div class="person_info_bottom">
            <form method="POST" enctype="multipart/form-data">
                <div class="form_file_item">
                    <p></p>
                    
                    <div class="-fs-24 -gil-b -green pb-3">
                      Прикрепите фото карты <br />{$card->pan}
                    </div>
                    <input type="hidden" name="card_id" value="{$card->id}" id="" class="" />
                    <input type="file" name="file" id="add_file_card" class="input_file" data-card="{$card->id}"/>
                    <label for="add_file_card" class="btn btn-third js-labelFile">
                      <span class="js-fileName">Добавить файл</span>
                    </label>
                  </div>
            </form>
          </div>
          {else}
          <div class="person_info_bottom">
            <form method="POST" enctype="multipart/form-data">
                <div class="form_file_item">
                    <p></p>
                    <input type="file" name="file" id="add_file" class="input_file"  />
                    <label for="add_file" class="btn btn-third js-labelFile">
                      <span class="js-fileName">Добавить файл</span>
                    </label>
                  </div>
            </form>
          </div>
          {/if}
        </div>
      </div>
      <!-- /общая информация -->

    </div>
  </div>
</main>
