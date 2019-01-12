Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E219C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5522177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547261262;
	bh=u7yXAAILupFI7Nj9wYc9SYZKxsE9ZL8329mAJXv4w00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m88JQPYvZWMWh+iEcPcmzntEKcuASj2lqxU1XAPS3Q0iKExCkvaq/rNwpZvJn958J
	 N+AcnkBwMPm23lxYcdWm2d4bkobYqI2wRuGrDDe+/VRgKhPcVrkvgJtX+1pEgMa4MM
	 bsIymylsvm7MKpgsLlYMdQ4Y0vd4IHMBkN1be5ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfALCrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbfALCrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:47:41 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6B72084E;
        Sat, 12 Jan 2019 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547261260;
        bh=u7yXAAILupFI7Nj9wYc9SYZKxsE9ZL8329mAJXv4w00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOA9ZbXzzu/OqIck8h59X6AVhpB7pSVXSufasjgXO7Choj0e2Y9D8vldlzDoE+TmV
         jzrAgdNvtD0mJOJW24KFGPZqnvpT8gAaZgb6KhOrVDw67ssUNF/qwl60l0eoOFS7/R
         /BZxBrN7R7a5pWT9CrwaYMB6aa+OazEu9fIIrtvE=
Date:   Sat, 12 Jan 2019 10:47:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Message-ID: <20190112024725.GO32649@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> Add the dpaa2-console device tree node for the following
> DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

DTS patch generally goes to the last in a series.

Shawn
