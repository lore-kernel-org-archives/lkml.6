Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeBKVHm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:07:42 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33584 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeBKVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:07:38 -0500
X-Google-Smtp-Source: AH8x226WbvGHO4LdcSko8cMIgcxz58EIE6264seQWE0xWVTW1bGq2f1fpV1rSgANuMiq4qjFQD7J4Q==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] fujitsu-laptop: Miscellaneous cleanups
Date: Sun, 11 Feb 2018 22:07:20 +0100
Message-Id: <20180211210727.12130-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of the two patch series I started preparing back in
June 2017 [1].  It took me this long to post it purely due to permanent
spare time shortage, not because the changes are complicated. 

The patch series contains miscellaneous cleanups which I think are worth
getting done before splitting fujitsu-laptop into two separate modules.
I am not 100% sure that all the changes in the last patch in this series
actually help, so please speak your mind.

This patch series was tested on a Lifebook S7020.  AFAICT it does not
conflict with the recent draft patch from Jan-Marek Glogowski and may
thus be applied independently.

Finally, please forgive me if it takes me weeks or months to address
review comments.  It is also perfectly fine for reviews to take weeks or
months ;)

[1] https://www.spinics.net/lists/kernel/msg2534759.html

 drivers/platform/x86/fujitsu-laptop.c | 179 +++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 89 deletions(-)

-- 
2.16.1
