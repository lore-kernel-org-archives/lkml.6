Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912CAC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4619A219EE
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 15:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4619A219EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHLSM1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:12:27 -0400
Received: from sauhun.de ([88.99.104.3]:45176 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbeHLSM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:12:27 -0400
Received: from localhost (p5B0B5C8B.dip0.t-ipconnect.de [91.11.92.139])
        by pokefinder.org (Postfix) with ESMTPSA id EC74472C4F1;
        Sun, 12 Aug 2018 17:34:00 +0200 (CEST)
Date:   Sun, 12 Aug 2018 17:34:00 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter.korsgaard@barco.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: i2c:ocores: fixes and polling mechanism
Message-ID: <20180812153400.GA1010@kunai>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
 <5011687.103nMUzm2u@harkonnen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <5011687.103nMUzm2u@harkonnen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> sorry to disturb you all but after one month and a half I never received 
> any comment about this patch set and I fear it ended up in a forgotten 
> corner. I would like to know if someone is considering it or not.

Adding Peter to CC using his latest EMail address.

Peter, you said you wanted to update MAINTAINERs with the new address?

