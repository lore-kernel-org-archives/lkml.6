Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031699AbeEXRIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:08:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33004 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031376AbeEXRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:08:16 -0400
X-Google-Smtp-Source: AB8JxZrxYbEkaXxsbpm8r0EhTeWv2td9AdFPs3uhEM6m2iojh6b8TEnvLep+C/t2vm+iF9zzIMUUVw==
Date: Thu, 24 May 2018 10:08:13 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH 07/14] fpga: bridge: kernel-doc fixes
Message-ID: <20180524170813.GD4051@archbook>
References: <20180516235007.3951-1-atull@kernel.org>
 <20180516235007.3951-8-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516235007.3951-8-atull@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 06:50:00PM -0500, Alan Tull wrote:
> Fix the following warnings when documentation is built:
> 
> ./drivers/fpga/fpga-bridge.c:143: warning: Function parameter or
> member 'info' not described in 'fpga_bridge_get'
> 
> ./drivers/fpga/fpga-bridge.c:1: warning: no structured comments found
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 164eb55..4b207a7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -121,6 +121,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
>  /**
>   * fpga_bridge_get - get an exclusive reference to a fpga bridge
>   * @dev:	parent device that fpga bridge was registered with
> + * @info:	fpga manager info
>   *
>   * Given a device, get an exclusive reference to a fpga bridge.
>   *
> -- 
> 2.7.4
> 
