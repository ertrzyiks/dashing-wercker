# Dashing Wercker widget

A [Dashing](http://github.com/shopify/dashing) widget for [Wercker](http://wercker.com)

![](/screenshots/screenshot_widget.png?raw=true)

Version with multiple builds on single widget can be found here: https://github.com/ertrzyiks/dashing-wercker-list

## Requirements

1. [Dashing](http://github.com/shopify/dashing)
2. A [Wercker](http://wercker.com) account
3. The contents of this repo

## Setup

1. `git clone git@github.com:ertrzyiks/dashing-wercker.git`
2. Copy Wercker logo to your assets

  ```
  mkdir -p dashing/assets/images
  cp dashing-wercker/assets/images/wercker_logo_shield_black.png dashing/assets/images
  ```
3. Copy `Wercker` widget into your dashing project widgets

  ```
  mkdir -p dashing/widgets/wercker
  cp -R dashing-wercker-list/widgets/wercker dashing/widgets/wercker
  ```
4. Add `wercker.rb` job to dashing jobs

  ```
  cp dashing-wercker/jobs/wercker.rb dashing/jobs
  ```

## Config

There is config array on the top of jobs/wercker.rb:

```
projects = [
  { :widget_id => 'wercker_project_1', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION', :branch => 'master' },
  { :widget_id => 'wercker_project_2', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION', :branch => 'development' }
]
```

Fill it with Wercker application informations and choose branch.

[Generate token](https://app.wercker.com/#profile/tokens) and expose it in `WERCKER_AUTH_TOKEN` environment variable.

## Dashboard

To display your dashboard you can use the `dashboards/wercker.erb` as example:

```html
<div class="gridster">
  <ul>
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="WIDGET_ID" data-view="Wercker"></div>
    </li>
  </ul>
</div>
```
