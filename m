Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9480FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F72F21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550162790;
	bh=dceFEsGSWJJh1V1jIcU3AxMP5LNzG2CWor+3oLfDEGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GiAECYJzjEzboMx9hudESrDd3zK1H2XNKrfB645BpmG7bqSuoJNGCyKrUX/XYAu+G
	 Kct5sRvNZtRu3OVzbU0eHptyao+2BHftx96Xn4g5mfdizGbI7KXASbgqs56a2FN4rP
	 s8gY7VFQowuO22GZXKDiR7LA+tZUeOSszq4Syo1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391716AbfBNQq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfBNQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:46:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99D7222DC;
        Thu, 14 Feb 2019 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550162788;
        bh=dceFEsGSWJJh1V1jIcU3AxMP5LNzG2CWor+3oLfDEGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDJYvvnhfvgVfx0QJp3CZdqKQAeD361B4tf63Ow0cmKJKhfg2oXrZdDKUyngUxsl6
         Adb39LSIT18ehLCWG9i6fs0whMOkDckwetO7ogQulqARoLmuhdfqCa9aUqs1uERH3G
         Vfgwm1AwRjgybbqU40j//dbJq5eDbaE6LV0rnyX4=
Date:   Thu, 14 Feb 2019 17:46:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rppt@linux.ibm.com, olof@lixom.net,
        ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v5 00/15] Habana Labs kernel driver
Message-ID: <20190214164600.GA30637@kroah.com>
References: <20190214160114.26314-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214160114.26314-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 06:00:59PM +0200, Oded Gabbay wrote:
> Hello,
> 
> This is v5 of the Habana Labs kernel driver patch-set. The changes in this
> version are mainly fixes to warnings that appear when compiling to i386
> architecture.

Thanks, let me apply this to the tree and see what happens!  :)

greg k-h
