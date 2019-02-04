Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8AAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDE5207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278857;
	bh=f+0dLjvD+bzlItxqfWCSS4CPs0tuzBnJC1j68qdPIhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pIgx/ymoMi+OIIqa1TSinshVXds86dO0NmmXsUXP4rRVNwVoQe0Na3jwsznrjKMIf
	 2ufD+DI4mZjtrwsqIxeosMFrPGiE7l7hQb8PUHVDq6973WcvH7EuaZ/XQShTSUIESp
	 Y3ly5NklPVuVRsBysp4Qt7dBoUQexbbub3XXq52U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfBDLOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfBDLOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:14:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5ACA207E0;
        Mon,  4 Feb 2019 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549278847;
        bh=f+0dLjvD+bzlItxqfWCSS4CPs0tuzBnJC1j68qdPIhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEeHH0OMSCaa3PcgWrs7nX9maq/n3SDzHHJtSs6hGuy7ib8DSTjG1x3cdt6wuLTUA
         7P/4R/wqYIXBkiRIEI1QiShvbidW8zT/WWrP+9dXocQfgHCq1Wu1e+HVq5G2tAOllW
         62Muf07LnQjEoCGHoSZXsbtVsi2kTyuPTV1Zy9q8=
Date:   Mon, 4 Feb 2019 12:05:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] staging/vboxvideo: Add TODO
Message-ID: <20190204110539.GC19811@kroah.com>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
 <20190204103114.30772-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103114.30772-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:31:14AM +0100, Daniel Vetter wrote:
> Noticed why wonder what vboxvideo is using the ->master_set/drop hooks
> for.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Fabio Rafael da Rosa <fdr@pid42.net>
> Cc: Nicholas Mc Guire <der.herr@hofr.at>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
