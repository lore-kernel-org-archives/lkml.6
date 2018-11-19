Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89929C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A118206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A118206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeKST5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:57:04 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:55793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKST5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:57:04 -0500
Received: from [192.168.178.52] ([109.104.46.191]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsIfc-1fZSzk0J6A-00thjo; Mon, 19 Nov 2018 10:33:42 +0100
Subject: Re: [PATCH 13/17] pwm: bcm2835: Switch to SPDX identifier
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <1541866978-7943-1-git-send-email-stefan.wahren@i2se.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <00989205-1712-09ab-e73e-1c189e6d83d1@i2se.com>
Date:   Mon, 19 Nov 2018 10:33:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541866978-7943-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:Kdfmp9+hXLadzWF6KAJYkZzk6v/ekNfljzwXNVVvN9iE8PyMgT6
 dETS+6FXCxnATJ7YQAdsMBWrC7epCqkj1nOnQGT1CMn4g/jmpyuXz/aabsc23ERi7uNSolZ
 P/DPRi51EhaXJx5l0PhwBp+mVu7rjwHWM9dmu3ynsU/m1HW4mNF91/os9X0XW3rR83kvrYg
 aXxnyiD2HdgBa217mQ9wQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DiAiN5DTX7A=:/8rUVZml8lq3DzbCPiIpQq
 hp7Ih//scU534nZwOSIynZ8jwdpQ4XEKi0dfnWv45umP+OMpOTbo9xCEj99h+XOKIZmR3LCTc
 6uwZcgzoOFYeY10a1SdpwHf7m0w+jyYNNeqlT2gnsKoBgJF8ksJ6qPLOIA7Q4sNGqG723vP3U
 ISb9HrGzPMpWZ8WktmOSDK3NvXMWgFPGV5cv8DLSnZBlK2xGugHEUbB8b2lBaKLECwBieLNUB
 XCtnaKd4xcQJgnthOX3aBbDt5sV34WvUIFKTPOEzzMrgqD2hbm/4OdZvfVJ8FXq0S6e5JEIuh
 87Ibx7tgHfJUyPc+bG8drZV3MpXNSMu10lX18lBebYMch8uVka728b+iiOsObv9ZArT9+bYIZ
 weywlzgQ1KicuX33VNd65uNjrhMBMasPxQMU4+lazSd7gmvwjqDx6N8aJhU++NTZ6+Rw5RFRJ
 pLjZqOYdENlMR/4PIu74NBi0VRDSAYAj6UJHosRRfVlIWYls3VGZMnI/tDQsYI282tthTr7jA
 9fZrZhzuCsQ+a09KJywYi8JPCmjwizFtCA80MX9wbZh2hTTMqTxeoSLNvARVDd3OLdE1HLgwY
 JxiVszOZkq4KdGzeoaTkYof6YRb/R1jMhCoHrGUTjHqZKgaH9+Iw/r2n28xflUMkbnTv1q/md
 0zESuCJHk7o0lcahR6MDX66BCeABjr0LngzTM/l88PyyD+MqHeAF6IK7sjJ8Ikiiv5wisecjC
 IfCqIOOz389fWn6GJnPytJytKNe0Y4DO3XPfsEXwbDa0uMuMh2KoWZ99F+dcnFMuyXSt133sS
 84L51tVCSfkbAf5c4QzJ0TxEt8fOfOLRIJyOaCmp3CoPZSWJh4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Am 10.11.2018 um 17:22 schrieb Stefan Wahren:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Cc: Bart Tanghe <bart.tanghe@thomasmore.be>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

are you fine with this patch?

Regards
Stefan

