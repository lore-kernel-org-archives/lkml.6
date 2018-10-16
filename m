Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D895C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4617820866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeJPMUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:20:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeJPMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:20:51 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6F04914513049;
        Mon, 15 Oct 2018 21:32:23 -0700 (PDT)
Date:   Mon, 15 Oct 2018 21:32:17 -0700 (PDT)
Message-Id: <20181015.213217.1378191449158771945.davem@davemloft.net>
To:     jian-hong@endlessm.com
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com,
        linux@endlessm.com
Subject: Re: [PATCH net] r8169: Enable MSI-X on RTL8106e
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAPpJ_ecr-tMNcpe=--MYyK3OWJiYEAoX7AnDBN63XO1OGZ4v_w@mail.gmail.com>
References: <20181001.225140.1939583158282424865.davem@davemloft.net>
        <CAPpJ_eduPv5RDNgUOw3K+XprZBfUVn_sSOLbDWjNtaGRssUgLA@mail.gmail.com>
        <CAPpJ_ecr-tMNcpe=--MYyK3OWJiYEAoX7AnDBN63XO1OGZ4v_w@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 21:32:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Mon, 15 Oct 2018 16:51:12 +0800

> 2018-10-02 13:57 GMT+08:00 Jian-Hong Pan <jian-hong@endlessm.com>:
>> David Miller <davem@davemloft.net> 於 2018年10月2日 週二 下午1:51寫道：
>>>
>>> From: Jian-Hong Pan <jian-hong@endlessm.com>
>>> Date: Thu, 27 Sep 2018 12:09:48 +0800
>>>
>>> > However, there is a commit which resolves the drivers getting nothing in
>>> > PCI BAR=4 after system resumes.  It is 04cb3ae895d7 "PCI: Reprogram
>>> > bridge prefetch registers on resume" by Daniel Drake.
>>>
>>> I don't see this upstream yet.
>>
>> It is in linux-next repository:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=04cb3ae895d7efdc60f0fe17182b200a3da20f09
> 
> The commit is also back ported into Linux kernel 4.19-rc7 now.
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=083874549fdfefa629dfa752785e20427dde1511

Patch applied, thanks.
