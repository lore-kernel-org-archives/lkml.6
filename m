Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81130C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DACC24E9B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLwJ+DMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DACC24E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeGCGMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbeGCGM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:12:28 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6DC24E9A;
        Tue,  3 Jul 2018 06:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530598348;
        bh=uHvBysp6OSthIqKwHBfYxJUhxlhaDpsqhcM4hHIuvX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLwJ+DMFaKTCfaMM5n7hKSNBn9Cc/Pgo4JcYzBkEe8V2Q0eVGggJsJ+5zx2H+o5Go
         RobvucJh5PBz35CsEg73jOXsCA2NSypOQkvyTo2B3DciFTMB2yID+CPrP8BzqBA/ep
         LlygVbMyDALP/x+CvljRAzTED/xbNH/fAJ/uPV3g=
Date:   Tue, 3 Jul 2018 14:12:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nick Dyer <nick@shmanahar.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        devicetree@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1] ARM: dts: imx51-zii-rdu1: correct touchscreen axis
 inversion
Message-ID: <20180703061212.GG4348@dragon>
References: <20180628225626.26203-1-nick@shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628225626.26203-1-nick@shmanahar.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:56:26PM +0100, Nick Dyer wrote:
> The RMI4 touchscreen driver applied inversion and axis swap in the
> wrong order, violating the DT binding for those properties. This was fixed in
> 645a397, so correct the RDU1 DT to apply the inversion to the
> correct axis.
> 
> Tested on Zii RDU1 00-5105-30 rev B
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Applied, thanks.
