Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeEVOj1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:39:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45361 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751445AbeEVOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:39:20 -0400
X-ME-Proxy: <xmx:lSsEW0i0Rz2t9b7I0YzjKAdiOF1wHsXlmlJsvsF3z-MOFFfz8-laFQ>
X-ME-Proxy: <xmx:lSsEWxGgYYm9D-QlF7yDEPeA5AdRFd7Nd_UgzklQLBcyNmnNAhKDGg>
X-ME-Proxy: <xmx:lSsEW2zlHqGR8LyYRZ1NKgilyhw-oC3mmXBwlnE3cxLBPSozNihIZQ>
X-ME-Proxy: <xmx:lSsEW0lNOTAme8xb4C-Fsf351OJTs_rHILtX0tFvyIE-oWCItO6ZDQ>
X-ME-Proxy: <xmx:lSsEW3GlzL0GSrjrzzEMp0JHuqs0KecXxWLUKJiOeDRGDBlZhiHuiA>
X-ME-Proxy: <xmx:lSsEW6mxmIfYaV8McGkLiWID5J4QP15_ZBCflhEZp4QDS5pfsbBkmw>
X-ME-Sender: <xms:lSsEWx9AouvXQv1WWup_drf-7_GdVQfOhhWBf068ZX3iyxLknCRsgA>
Date: Tue, 22 May 2018 07:39:14 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Colin King <colin.king@canonical.com>
Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix spelling mistake: "Inavlid" ->
 "Invalid"
Message-ID: <20180522143914.GA28655@animalcreek.com>
References: <20180522083342.5722-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522083342.5722-1-colin.king@canonical.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 09:33:42AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/greybus/audio_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index de4b1b2b12f3..15e57f701630 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -996,7 +996,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>  
>  	ret = gbaudio_validate_kcontrol_count(w);
>  	if (ret) {
> -		dev_err(module->dev, "Inavlid kcontrol count=%d for %s\n",
> +		dev_err(module->dev, "Invalid kcontrol count=%d for %s\n",
>  			w->ncontrols, w->name);
>  		return ret;
>  	}

Acked-by: Mark Greer <mgreer@animalcreek.com>
