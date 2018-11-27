Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682B5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CAB21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag8IHJ3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CAB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeK1Blp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeK1Blo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:41:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83FEC20817;
        Tue, 27 Nov 2018 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543329816;
        bh=6pzUgwS5MX2otTwkscnzJkYqPkKIhSKpGZHda5OdE98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ag8IHJ3VAWjwc/nKqLiUHyhJS2dECpN3iaHMteU9r2UDksID0tK62BEo6pMlaEe0S
         1AGCTZaYRwt818yb+15C42YNLhxlrpJ5Npz8nL+pv9KUfV4cxzlKTKN1SZW/ydtm+H
         O6VG7keyWZ8vtuE2A7rhru8Cm4h333KPwp5phfrE=
Date:   Tue, 27 Nov 2018 15:43:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: libsas: Add missing license and update to SPDX
 license identifier
Message-ID: <20181127144333.GA11004@kroah.com>
References: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:15:32PM +0800, John Garry wrote:
> Currently sas_task.c has no license specifier, so add SPDX license
> identifier for GPL-2.0+.
> 
> As mentioned in commit b24413180f56 ("License cleanup: add SPDX GPL-2.0
> license identifier to files with no license"), files with no license in
> the kernel are under default kernel license.

The default is GPLv2, not v2+.

> 
> While I'm at it, all other libsas source code files are updated to use
> SPDX license identifier for GPL-2.0+.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
> index 13739bfa..bdc6bce 100644
> --- a/drivers/scsi/libsas/Kconfig
> +++ b/drivers/scsi/libsas/Kconfig
> @@ -4,22 +4,7 @@
>  # Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
>  # Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>  #
> -# This file is licensed under GPLv2.
> -#
> -# This program is free software; you can redistribute it and/or
> -# modify it under the terms of the GNU General Public License as
> -# published by the Free Software Foundation; version 2 of the
> -# License.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program; if not, write to the Free Software
> -# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> -# USA
> +# SPDX-License-Identifier: GPL-2.0+

No, the above license is GPLv2 only, do NOT change the license of a file
unless you have permission to do so.

Also, the spdx line goes at the first line of the file.


>  #
>  
>  config SCSI_SAS_LIBSAS
> diff --git a/drivers/scsi/libsas/Makefile b/drivers/scsi/libsas/Makefile
> index 5d51520..75998b7 100644
> --- a/drivers/scsi/libsas/Makefile
> +++ b/drivers/scsi/libsas/Makefile
> @@ -4,22 +4,7 @@
>  # Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
>  # Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>  #
> -# This file is licensed under GPLv2.
> -#
> -# This program is free software; you can redistribute it and/or
> -# modify it under the terms of the GNU General Public License as
> -# published by the Free Software Foundation; version 2 of the
> -# License.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program; if not, write to the Free Software
> -# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> -# USA
> +# SPDX-License-Identifier: GPL-2.0+

Again you changed the license, not good :(

Please do not make these types of changes unless you really know what
you are doing, it is not ok to change the license of files.

greg k-h
