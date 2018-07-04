Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC9FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C4523E36
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="OD25LJBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C4523E36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeGDP4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:56:55 -0400
Received: from canardo.mork.no ([148.122.252.1]:34569 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeGDP4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:56:53 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w64Fum71008479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Jul 2018 17:56:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1530719809; bh=t+QPBduXQYgCWrok6bRByYi+uT8eDdUXu1HYUTpse+s=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=OD25LJBfCfrZE7nHOm1jEwaPE4eI2o4/TnSdmCjpwqFEQ0+DyBF1utum0pODUdgUn
         BpygLhpgc60f0IjaiywMpNhFIYkVFXd/ziEX6wRZ04iLisjqrQMdypbTrxFYzIRxw+
         C8vceP6fVSmwCUI5ge4chseTwvY6H1CikUhqDsK4=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1fak9A-000561-KM; Wed, 04 Jul 2018 17:56:48 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     =?utf-8?Q?Matev=C5=BE_Vu=C4=8Dnik?= <vucnikm@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qmi_wwan: add support for Quectel EG91
Organization: m
References: <1530715205-13676-1-git-send-email-vucnikm@gmail.com>
        <BF4DBDBE-6C53-4E81-BA2F-DD89B19CB84A@mork.no>
        <CAJRueBROA936kdgmH3kwp0X4CD=Y+KJ7_iqzuZ8dJqidBRzYiA@mail.gmail.com>
Date:   Wed, 04 Jul 2018 17:56:48 +0200
In-Reply-To: <CAJRueBROA936kdgmH3kwp0X4CD=Y+KJ7_iqzuZ8dJqidBRzYiA@mail.gmail.com>
        (=?utf-8?Q?=22Matev=C5=BE_Vu=C4=8Dnik=22's?= message of "Wed, 4 Jul 2018
 17:16:16 +0200")
Message-ID: <87fu0zgfjz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.99.3 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matev=C5=BE Vu=C4=8Dnik <vucnikm@gmail.com> writes:

> Sorry, I missed this one. It's a good idea to keep numerical order. Is it=
 ok
> to fix it and send a new patch?

Yes, sure. Just label it as v2 or similar to make it clear that it's a
new version of the same patch.



Bj=C3=B8rn
