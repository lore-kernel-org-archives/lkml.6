Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeFBO0w (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:26:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43770 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFBO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:26:50 -0400
X-Google-Smtp-Source: ADUXVKKoF2Ml6LPDJIeAOjk9s6dLCQ+y7fSAy9zXPjDDRLBUmxBoa14Ha+SmE88Z4tT1eqUv53iAlQ==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v2 0/5] staging: mt7621-spi: Fix Coding style issues.
Date: Sat,  2 Jun 2018 19:56:00 +0530
Message-Id: <20180602142605.6846-1-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601091553.GA5821@kroah.com>
References: <20180601091553.GA5821@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series lists different changes for coding style fixes
as reported by checkpatch.pl, changes can be broken down as :

1. Indent switch and case labels at the same level
2. Fix a line over 80 columns
3. Place tabs for indentation instead of spaces
4. Add a space before open paranthesis in switch 
5. Remove unnecessary braces {} from single statement if

version 2 changes
- segregated changes in individual commits as per fix category

Sankalp Negi (5):
  staging: mt7621-spi: Fix Coding style issues reported by
    checkpatch.pl.
  staging: mt7621-spi: Fix Coding style issues reported by
    checkpatch.pl.
  staging: mt7621-spi: Fix Coding style issues reported by
    checkpatch.pl.
  staging: mt7621-spi: Fix Coding style issues reported by
    checkpatch.pl.
  staging: mt7621-spi: Fix Coding style issues reported by
    checkpatch.pl.

 drivers/staging/mt7621-spi/spi-mt7621.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.11.0
