Return-Path: <outreachy-kernel+bncBDYZDG4VSMIRBPFLZDKQKGQEQMNS2XQ@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521620412; cv=pass;
        d=google.com; s=arc-20160816;
        b=jmV5yxsanyPtB0rMiaLmQ+AK4SXx63LMPCh6Kd/kVvK5ZsFzu7BIGF/6q8DUxwQckU
         rwu+bHFQgk0gEqoLgv5iuRmWaOpfLnb+Yu3dpY1FTXRanSHmsjycyJFpTcMDr22+QLcp
         AH5C3eWAFWDHYJZoMiC9vVwwk7VGc6ETv/M01yEMM6sMkGhVNhHsujpqfFmVoGe4Q2dl
         8NQsFajlVuCYUPVGhFhxfzCvZmSDKQbCGpfi2nld5jOT39GmBYTO4xOiWnWoVdDXeXMt
         m48sUSHnincSCIunRaF1XafcEaOI2Tm1x7L3Xtb0vRnroTDx/w06moTx5xqo63ABlHXV
         4aag==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:arc-authentication-results:arc-message-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=zTe5tmCQaOJHT+Yq3jN+Yeydd6xXNU92SvdM2lp2MlQ=;
        b=KqIZaiswZzJX8AZu2/kO7X1UB1jI6OsN7lN9uI4XTbkFtylizrIjTX46UYPcWxAZaJ
         sip+iaJWNiW89NzlLt8XDxvIg1ba5hjC4Q3KoDFqxyxUUsW8+9q6QfQby89KuauqNbra
         vfTsqlilUhZUaNVDbfPgLCD5aQT7mY9MUFahfMOOT1WDus6xowZoPe+byQUYzYQSKY/+
         I9x6kIHYcpN1aaNQ/wcOnFxSm5qg/GGlmAPsmxThiGNRjYFCKhLnC9KS9Q+8BpCvWrg8
         hYHNp3nChj3IZSABccU9es1ZV60YkSbmiiVbPNxZMiYUUR6YWwYTy/d7B5aDHY7IgcNE
         tQGg==
ARC-Authentication-Results: i=3; mx.google.com;
       arc=pass (i=2 dkim=pass dkdomain=ffwll.ch);
       spf=pass (google.com: domain of outreachy-kernel+bncbdyzdg4vsmirbpflzdkqkgqeqmns2xq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDYZDG4VSMIRBPFLZDKQKGQEQMNS2XQ@googlegroups.com
Authentication-Results: mx.google.com;
       arc=pass (i=2 dkim=pass dkdomain=ffwll.ch);
       spf=pass (google.com: domain of outreachy-kernel+bncbdyzdg4vsmirbpflzdkqkgqeqmns2xq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDYZDG4VSMIRBPFLZDKQKGQEQMNS2XQ@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521620412; cv=pass;
        d=google.com; s=arc-20160816;
        b=eLNSXLgxpjNHDgw8hoOpbqg+6TbFkFY+OVCqU0SKmJjMY6wdeG7uhl/Wx2CvxfXsYp
         HyLv6a2Vp3Ivgl6Uu1iAqcn/L/d4GiKH7P69geBnxgtad2Sh0uZTpabDYyMHoJo7qhEc
         9ZxiuSaQ4Uj7NB2OBGToeXgMw16JYSEMpnuPpPoflTTCoI74rVjH2duWlOKHfVw4fDNF
         PxXGprx9Y8SSiQOidV4Go+rrfXCICaLcX0gdjbfjzGtgSRDwsqqOno1lf7hQIVf57IM6
         adcj38E5em+kLLy6xufEtj3DtML0Kln/DGHWx2NOmRsduYG4dOgbZQ5ptKZNgEKfIL6J
         VX+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=zTe5tmCQaOJHT+Yq3jN+Yeydd6xXNU92SvdM2lp2MlQ=;
        b=AW6g8hrs7o7P1xpz8+IZn+0EDSZsIoFkknMGCnz3dk81PEbsf5DFFrztidxzNm0yiV
         S1GirEWLM5GXAc8ZydR+k9TDfQshnqyXb4lSiYwcWZc6PYsBiNMKO7bKVuUM7gC179fn
         VD+975MXs/Bnib+/dwxpWpbbM8V2dmZa+6eFkrDf3Jl2ZvMUPiYhb6DOCjQic82STnCV
         PkqmUqHdu3ZN/eqF4JOELfycn0kPV++96+b/JDdXhkrlB4v37dRe3HH5k6l+RZ0AOeJq
         IrVPI3UnsVbhCeznryJzk1le816hSBGRGRgzr1SZQzhXJ6VpmtUOSoaYIZJX8EtzARfz
         8TWA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=HwBPe8NH;
       spf=neutral (google.com: 2a00:1450:400c:c09::22a is neither permitted nor denied by best guess record for domain of daniel@ffwll.ch) smtp.mailfrom=daniel@ffwll.ch
X-Google-Smtp-Source: AG47ELuSA/HcuGLEx+PySvglUf92bDm42CCg76WFx0cseZfPdIoWnFFdkNtaYFeFTJW/Toanu/no+g==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521620411; cv=none;
        d=google.com; s=arc-20160816;
        b=VaR6HlQAfAfvbs5hedaOZLlnSsMXnXGLz24H+1Cs70rum0n8Lw1ZTifkFI9ser8uKv
         9j46acPct8PWcBMuT2j2KS+ANAiUnVp/un9ojWlODDRfBL9P9YEbPdUE9BU9988/ePLk
         ti/tUVbXutSTLRnDwe46x5dkvSge3umzFCmWynQ0wYmbhNBotYMjocEhddUGHDkF1QSV
         omXVPwCN7mtxtQMP9HzzXyypM4bEbm3gw/JamE4Kj2E/LENb2bte3wE0Ox3J5i8+nJq3
         LBHA2nyWwM7Re8q2vKc1vU1gvUK4nXLbNvU3XGOnL5sMli6l8AIbyMVxof/e/xcfp9BA
         +vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:sender
         :dkim-signature:arc-authentication-results;
        bh=SLF8GGFsJaezCYk7EEP7lRRc1GjwcAEBfA2m2234oLk=;
        b=fH3fmCda1TuxSGWHjFIwvuK9LyPBBXLOzaY84vklMgp0RbLupGuZsCnZ2fAyt+Yeb3
         F6DNEp8+p1UEGeiL/UO3cm0JdYG0Y9Y5SuBto/4fjo3ka5+7SgCcsgCM+NNXv+10WKDD
         WhyUMb32WaeMmVgTGRrs8W5N7b5zC1tYwBwJ47LBTPRMZVt7wTtdIqdnkHQQylvwGHQs
         fJQrDraWj0cIeW9Q0DHUIlv1/z2hKmHGnYuFbxq1zDBqPS5Rpp2VV8KeyCyNf/VxjzUb
         O75+y94/anbv85nRMDti6iln6UEJxFTucIz1R2HL80rxdIbuS++N3BlYgfMjq5GmpofB
         TOKw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=HwBPe8NH;
       spf=neutral (google.com: 2a00:1450:400c:c09::22a is neither permitted nor denied by best guess record for domain of daniel@ffwll.ch) smtp.mailfrom=daniel@ffwll.ch
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 21 Mar 2018 09:20:08 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Santha Meena Ramamoorthy <santhameena13@gmail.com>
Cc: airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie,
	virtualization@lists.linux-foundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com, seanpaul@chromium.org,
	daniel.vetter@intel.com
Subject: Re: [Outreachy kernel] [PATCH] drm/qxl: Replace drm_gem_object_reference/unreference()
 with _get/put()
Message-ID: <20180321082008.GX14155@phenom.ffwll.local>
Mail-Followup-To: Santha Meena Ramamoorthy <santhameena13@gmail.com>,
	airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie,
	virtualization@lists.linux-foundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com, seanpaul@chromium.org,
	daniel.vetter@intel.com
References: <1521570567-22519-1-git-send-email-santhameena13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1521570567-22519-1-git-send-email-santhameena13@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Original-Sender: daniel@ffwll.ch
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@ffwll.ch header.s=google header.b=HwBPe8NH;       spf=neutral
 (google.com: 2a00:1450:400c:c09::22a is neither permitted nor denied by best
 guess record for domain of daniel@ffwll.ch) smtp.mailfrom=daniel@ffwll.ch
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595482431750972321?=
X-GMAIL-MSGID: =?utf-8?q?1595534645748544830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:29:27AM -0700, Santha Meena Ramamoorthy wrote:
> Replace drm_gem_object_reference/unreference function with *_get/put()
> suffixes, because it is shorter and consistent with the kernel
> kref_get/put() functions. The following Coccinelle script was used:
> 
> @@
> expression e;
> @@
> 
> (
> -drm_gem_object_reference(e);
> +drm_gem_object_get(e);
> |
> -drm_gem_object_unreference(e);
> +drm_gem_object_put(e);
> |
> -drm_gem_object_unreference_unlocked(e);
> +drm_gem_object_put_unlocked(e);
> )
> 
> Signed-off-by: Santha Meena Ramamoorthy <santhameena13@gmail.com>

lgtm, thanks for your patch. Applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 4 ++--
>  drivers/gpu/drm/qxl/qxl_dumb.c    | 2 +-
>  drivers/gpu/drm/qxl/qxl_fb.c      | 6 +++---
>  drivers/gpu/drm/qxl/qxl_gem.c     | 2 +-
>  drivers/gpu/drm/qxl/qxl_ioctl.c   | 4 ++--
>  drivers/gpu/drm/qxl/qxl_object.c  | 6 +++---
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 9a9214a..ecb35ed 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -309,7 +309,7 @@ void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  	struct qxl_bo *bo = gem_to_qxl_bo(qxl_fb->obj);
>  
>  	WARN_ON(bo->shadow);
> -	drm_gem_object_unreference_unlocked(qxl_fb->obj);
> +	drm_gem_object_put_unlocked(qxl_fb->obj);
>  	drm_framebuffer_cleanup(fb);
>  	kfree(qxl_fb);
>  }
> @@ -1215,7 +1215,7 @@ qxl_user_framebuffer_create(struct drm_device *dev,
>  	ret = qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj, &qxl_fb_funcs);
>  	if (ret) {
>  		kfree(qxl_fb);
> -		drm_gem_object_unreference_unlocked(obj);
> +		drm_gem_object_put_unlocked(obj);
>  		return NULL;
>  	}
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
> index 11085ab..c666b89 100644
> --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> @@ -82,6 +82,6 @@ int qxl_mode_dumb_mmap(struct drm_file *file_priv,
>  		return -ENOENT;
>  	qobj = gem_to_qxl_bo(gobj);
>  	*offset_p = qxl_bo_mmap_offset(qobj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
> index 23af3e3..3388914 100644
> --- a/drivers/gpu/drm/qxl/qxl_fb.c
> +++ b/drivers/gpu/drm/qxl/qxl_fb.c
> @@ -95,7 +95,7 @@ static void qxlfb_destroy_pinned_object(struct drm_gem_object *gobj)
>  	qxl_bo_kunmap(qbo);
>  	qxl_bo_unpin(qbo);
>  
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  }
>  
>  int qxl_get_handle_for_primary_fb(struct qxl_device *qdev,
> @@ -316,11 +316,11 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
>  		qxl_bo_unpin(qbo);
>  	}
>  	if (fb && ret) {
> -		drm_gem_object_unreference_unlocked(gobj);
> +		drm_gem_object_put_unlocked(gobj);
>  		drm_framebuffer_cleanup(fb);
>  		kfree(fb);
>  	}
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
> index 85f5467..f5c1e78 100644
> --- a/drivers/gpu/drm/qxl/qxl_gem.c
> +++ b/drivers/gpu/drm/qxl/qxl_gem.c
> @@ -98,7 +98,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
>  		return r;
>  	/* drop reference from allocate - handle holds it now */
>  	*qobj = gem_to_qxl_bo(gobj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
> index e8c0b10..e238a1a 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -121,7 +121,7 @@ static int qxlhw_handle_to_bo(struct drm_file *file_priv, uint64_t handle,
>  	qobj = gem_to_qxl_bo(gobj);
>  
>  	ret = qxl_release_list_add(release, qobj);
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	if (ret)
>  		return ret;
>  
> @@ -343,7 +343,7 @@ static int qxl_update_area_ioctl(struct drm_device *dev, void *data,
>  	qxl_bo_unreserve(qobj);
>  
>  out:
> -	drm_gem_object_unreference_unlocked(gobj);
> +	drm_gem_object_put_unlocked(gobj);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index f6b80fe..e9fb0ab 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -211,13 +211,13 @@ void qxl_bo_unref(struct qxl_bo **bo)
>  	if ((*bo) == NULL)
>  		return;
>  
> -	drm_gem_object_unreference_unlocked(&(*bo)->gem_base);
> +	drm_gem_object_put_unlocked(&(*bo)->gem_base);
>  	*bo = NULL;
>  }
>  
>  struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo)
>  {
> -	drm_gem_object_reference(&bo->gem_base);
> +	drm_gem_object_get(&bo->gem_base);
>  	return bo;
>  }
>  
> @@ -318,7 +318,7 @@ void qxl_bo_force_delete(struct qxl_device *qdev)
>  		list_del_init(&bo->list);
>  		mutex_unlock(&qdev->gem.mutex);
>  		/* this should unref the ttm bo */
> -		drm_gem_object_unreference_unlocked(&bo->gem_base);
> +		drm_gem_object_put_unlocked(&bo->gem_base);
>  	}
>  }
>  
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1521570567-22519-1-git-send-email-santhameena13%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180321082008.GX14155%40phenom.ffwll.local.
For more options, visit https://groups.google.com/d/optout.
