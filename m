Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C85720672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C85720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504096AbeKWWuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:50:32 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:57387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbeKWWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:50:32 -0500
Received: from [192.168.178.52] ([109.104.55.85]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrhLw-1fcVaD13NU-00ngDg; Fri, 23 Nov 2018 13:06:13 +0100
Subject: Re: [PATCH 05/17] clocksource: bcm2835: Switch to SPDX identifier
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Arlott <simon@arlott.org>
References: <1541863719-7244-1-git-send-email-stefan.wahren@i2se.com>
 <dbc12f84-ebb1-998f-dd42-5ad936635744@linaro.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <993d127f-91d6-aca8-256a-87723389ef8b@i2se.com>
Date:   Fri, 23 Nov 2018 13:06:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <dbc12f84-ebb1-998f-dd42-5ad936635744@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:6aoHKLZ0T8zBGhmP8R2eJgd/4QX8KnxqZYD0AwtinKi08wAHqmn
 2mQUZG3tOJYK95feZoHEEPgKvaFvvJhP1+vI0+rN+wu8MWDm0Ce8HWhPL80kOeUPlggJMc6
 uf0q+NBu++pZU33FT7V2aiOpK/lQHBW3HetUhly9ligSY8YZtaJtBMue7t5orLR5YT/ZwgB
 VGzYDPKUL2Ki1E5ZARjsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WR+YM94Ox34=:rIGmAKbZhF5a2zKUqHjMn6
 34zCBDQ5TsB+JtqHLrxgcyuF7mJiYRKk0PXu7SAU0RqYB4T9Rz9ni7uN6d7q+pu5QT6onGOBg
 pf68bfjbszvUDRv1y61wNKu312s6Ru7xQCK+6oyHj4oEIN5tj9rlKTIxnFfgq2ArSpbDV0L2m
 Bxx4RUhrAyBV+UjJp9tdTOXfjVrG//SUWTpG8WnRaJbjlMdXb0gOnc1pzFLmHD12L/T9zghsj
 7pdggeZpwK2oB0ACDbf5KHzfKrYLTI8j0f5n5JWQoJ6K41sMNoceAgwAMCKtOOzIjlkENLgwS
 L83hA6hhERvMZ3bJNBXNwuYJ5j57OR0VEIwGWDd8Lyys+1rd2i4BN7rRfOjCg6siUrNLdFLA7
 2QJ5qMxkgrMngATD1bIh1vp2jbfshbTTCXK6hueGmeuU0gha+6CKjUBoPphsYgKptVx1TKcRu
 668WTCnv6geIQIl3q35BKEafG8LzNKziAlGWN6lgr+fQtMkSas8JqzRFZ1mfeQDQ2y1QPe8OH
 EgRirHKFYeVOjNUouQdKJAVes2lmtJ9CzU8K3QMjeFAh/mJfCFxBVI2NxRa5QiUymEGYRNkNi
 O/CCqG/gmX+xooE0gzEhjnAWM9s+qP840QUU0FUhqrmib1LgA+8Mj8gQpV7S1KUv3qvpTtT9T
 e4oPlf3/dKSzrBj2X9Dn84kk7IKwIRf4OqIFsZFxjb1/8VNY4BJXkMSF9dZ/uCCd9Kh3ME9TX
 o+DY/61+o15EPn0Ya6fM6lJv6B4I65YE6lN8bzRnSEaZiEoLCf6IH9xj8Sjyz32QnnB9rCzML
 6eDSbitJQTDvgX9T/fb2DsS/UqPJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 12.11.2018 um 07:56 schrieb Daniel Lezcano:
> On 10/11/2018 16:28, Stefan Wahren wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management. Also drop the FSF address.
>>
>> Cc: Simon Arlott <simon@arlott.org>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
>
thanks.

Can this patch go via your clockevents tree?

Stefan

