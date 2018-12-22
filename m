Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B18C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2BB2195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbeLVTCJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:02:09 -0500
Received: from poy.remlab.net ([94.23.215.26]:35954 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbeLVTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:02:09 -0500
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2018 14:02:08 EST
Received: from philogene.localnet (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id B134A5FFA8;
        Sat, 22 Dec 2018 10:35:19 +0100 (CET)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phonet: af_phonet: Fix Spectre v1 vulnerability
Date:   Sat, 22 Dec 2018 11:35:18 +0200
Message-ID: <2534569.ObK2OKVxXI@philogene>
Organization: Remlab Tmi
In-Reply-To: <20181221214117.GA1539@embeddedor>
References: <20181221214117.GA1539@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 21 décembre 2018, 23:41:17 EET Gustavo A. R. Silva a écrit :
> protocol is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.

No objections but AFAIR, only privileged userspace can trigger that code so 
the impact is kinda limited.

-- 
Rémi Denis-Courmont


