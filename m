Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B91C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B320B20660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547128680;
	bh=RpVf3BEE0pPwg3BCjGoRRZ5TTaMuz4TRJBaIlzP9Yaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wTgUqFBtNym99O95vlj48W/RqkxiZOgomgkIvr1++4WsPDSFePYiKONLEZ/pWshlt
	 lMEDZFYqSIzcOUQHgGvWkFU1/8PtNvt2fm83y0PO2SoSWRpkTlDiAq2Yq1aK8wtREh
	 La1eXuus7ufMK7aeU0RP8n+Eh1Z0JHVmS2DjEJpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfAJN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:57:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfAJN57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:57:59 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82727214DA;
        Thu, 10 Jan 2019 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547128678;
        bh=RpVf3BEE0pPwg3BCjGoRRZ5TTaMuz4TRJBaIlzP9Yaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noEj6BrdODZBXRPeNAoij3LIJBL9o9S9YP91ikgVpDxjbOOkjaZ32NFqNPnGdifMs
         MTGV7nPliNRpufWmiw/xD9CyTWFzPb1zw+bPb/hA1hp1x2z1CNkXeHXLJVC/y7aXFV
         laQJcstjt8HWpIP+AXJER1AMvLNH6TFQbGwoQ/Zo=
Date:   Thu, 10 Jan 2019 21:57:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Message-ID: <20190110135742.GC30487@dragon>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
 <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
 <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
 <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:11:50PM -0600, Rob Herring wrote:
> Humm, I thought Shawn had applied to his tree as there were some conflicts.
> 
> Shawn, do you need me to resend?

Sorry.  I was actually dropping the conflicting changes from my tree and
expecting you send the json-schema patch via your tree.  I just applied
your patch to my tree.

@Vokáč,

Please generate your patches against my for-next branch with dt-bindings
being separate patch from dts one.

Shawn
