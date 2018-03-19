Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbeCSNeg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:34:36 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35447 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933245AbeCSNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:34:34 -0400
X-Google-Smtp-Source: AG47ELuVubHviVd621n6FmQ+Dgmj+D9KqBkquLIAIj6J13QjfSdSnXTF/+571+tWRgvGq8TM3IfUDw==
Date: Mon, 19 Mar 2018 09:34:30 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Paul McQuade <paulmcquad@gmail.com>
Cc: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] GPU: drm: Fixed Spacing issue
Message-ID: <20180319133430.GI223881@art_vandelay>
References: <20180319005225.1545-1-paulmcquad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319005225.1545-1-paulmcquad@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:52:22AM +0000, Paul McQuade wrote:
> "foo * bar" should be "foo *bar"
> 
> Signed-off-by: Paul McQuade <paulmcquad@gmail.com>

Thank you for your patches. I've squashed them all into one, fixed up the commit
message and applied them to drm-misc-next.

Sean

> ---
>  drivers/gpu/drm/drm_bufs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index 1ee84dd802d4..83b3d0801262 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -129,7 +129,7 @@ static int drm_map_handle(struct drm_device *dev, struct drm_hash_item *hash,
>   * type.  Adds the map to the map list drm_device::maplist. Adds MTRR's where
>   * applicable and if supported by the kernel.
>   */
> -static int drm_addmap_core(struct drm_device * dev, resource_size_t offset,
> +static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
>  			   unsigned int size, enum drm_map_type type,
>  			   enum drm_map_flags flags,
>  			   struct drm_map_list ** maplist)
> @@ -361,7 +361,7 @@ static int drm_addmap_core(struct drm_device * dev, resource_size_t offset,
>  	return 0;
>  }
>  
> -int drm_legacy_addmap(struct drm_device * dev, resource_size_t offset,
> +int drm_legacy_addmap(struct drm_device *dev, resource_size_t offset,
>  		      unsigned int size, enum drm_map_type type,
>  		      enum drm_map_flags flags, struct drm_local_map **map_ptr)
>  {
> @@ -637,8 +637,8 @@ int drm_legacy_rmmap_ioctl(struct drm_device *dev, void *data,
>   *
>   * Frees any pages and buffers associated with the given entry.
>   */
> -static void drm_cleanup_buf_error(struct drm_device * dev,
> -				  struct drm_buf_entry * entry)
> +static void drm_cleanup_buf_error(struct drm_device *dev,
> +				  struct drm_buf_entry *entry)
>  {
>  	int i;
>  
> -- 
> 2.16.2
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
