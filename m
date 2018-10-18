Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10614C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FFF21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FFF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJRUdd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:33:33 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52739 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbeJRUdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:33:32 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1gD7Tm-002dNz-MP>; Thu, 18 Oct 2018 14:32:42 +0200
Received: from z92e7.pia.fu-berlin.de ([87.77.146.231] helo=[10.146.231.3])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          with esmtpsa (TLSv1.2:AES128-SHA:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1gD7Tm-003N5A-Cj>; Thu, 18 Oct 2018 14:32:42 +0200
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <113f6584-0645-3484-2847-627e8d17b9b4@physik.fu-berlin.de>
Date:   Thu, 18 Oct 2018 14:32:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: 87.77.146.231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 10/18/18 2:29 PM, Bartlomiej Zolnierkiewicz wrote:
> John, please test if possible..

Yes, will test ASAP. @Michael: Can you build an updated kernel from your
tree for elgar and copy it over. I'll make sure to test it and also
hook up an IDE drive for testing.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

