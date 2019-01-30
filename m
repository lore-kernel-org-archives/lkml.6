Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F078CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C454320857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548859051;
	bh=xP7Y2PV7QxqUFRW84hEpSMQVIFUeEAf3y+y/DT+da5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aVnWoptBPQjoY381hK+CDHX2X+HO35EKIU/y3lt6Dq+MtDzYqBttMZEz7aeGnPu2o
	 xG8Uzr509fSl8vH9ijnC8GKEEnFgKWGDBO3FNI8tixi13t1YmmNlmsGfFKJHrGZIgk
	 +h868y7JdU4sHcpIgIrzjieCR/IuKRqw3YnQbeKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfA3Oha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3Oha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:37:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E9F20882;
        Wed, 30 Jan 2019 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548859049;
        bh=xP7Y2PV7QxqUFRW84hEpSMQVIFUeEAf3y+y/DT+da5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEGnCJ3NhjIoTmNZWTyVS3iUtzbCR7hKGT897DRKeo9cIebBJVmttXJi3AOhT8daP
         iJnE9mG6vWRnN2K8nEcC4GiCpuQn5gSP+x456l57zYZDedd9UEnpywAEdFps/FsCDh
         Kh7Eis2/694o3OrMRQEMGPiqAiKY5EBB3CEu7/VM=
Date:   Wed, 30 Jan 2019 15:37:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michiel Schuurmans <michielschuurmans@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192e: Replaced spaces with tab.
Message-ID: <20190130143726.GA1744@kroah.com>
References: <20190126173121.GA20043@michiel-dev.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126173121.GA20043@michiel-dev.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 06:31:21PM +0100, Michiel Schuurmans wrote:
> Replaced the spaces with tabs as suggested by checkpatch.
> 
> This is my first patch.

No need for that line :)

Also, please use scripts/get_maintainer.pl to determine who to send a
patch to, and what mailing list next time.

thanks,

greg k-h
