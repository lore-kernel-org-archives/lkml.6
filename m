Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F04C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CCD218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545603699;
	bh=bbDfxViPXvfLw9tPWFFmoWlLg5szd6ujg9Z8ZYUABAU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=c9yH8WNJmjfM/8Ztxt+ZS3Zw8OBc0EymXrFnCu6gsyHHslnGdEqrk4Te+olmRnAsa
	 64p1o89jd2lkP9L9KCAaYd9lv7ydIO/h4cvbo5lMp9QS34YMQS7m7TovDMaD6goy/h
	 7wYsHE1CWbK7aNyJ2IKV5DDzF0ljuklLaDvC9zes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeLWWVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeLWWVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:21:38 -0500
Received: from [192.168.1.25] (unknown [195.142.208.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAEE217FA;
        Sun, 23 Dec 2018 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545603697;
        bh=bbDfxViPXvfLw9tPWFFmoWlLg5szd6ujg9Z8ZYUABAU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iou0TqBI5tgWzZXPXyr4qHK7dE+GmTXsoBiMdKV2BY3TRNiSxTxDak7pzcleYBbnQ
         llxZfpwq64u1vt5naTTWt0XdnoUAdQgwfW8hzxBtXlyeiTTpajifKL5s0vqXKIPJNi
         FoBrR5uutoUIsuIjqJpuXewfIlf/ko/wbEpzGzJk=
Subject: Re: [PATCH v2 01/11] ACPI / LPSS: Add guards against CONFIG_PCI
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-2-okaya@kernel.org>
 <CAJZ5v0hiBT5Zg5+sQekgjvcOVgfQsXcRutkTNEOEeAFHYYRz4A@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <470dd63f-97b8-abf0-3b2b-f1bedf9f3760@kernel.org>
Date:   Sun, 23 Dec 2018 23:21:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hiBT5Zg5+sQekgjvcOVgfQsXcRutkTNEOEeAFHYYRz4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/2018 10:45 PM, Rafael J. Wysocki wrote:
> No.
> 
> Please make this driver depend on PCI instead.

Sure.
