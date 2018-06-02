Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeFBSie (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:38:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41631 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeFBSid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:38:33 -0400
X-Google-Smtp-Source: ADUXVKJaPow8XO/4uJ0lteJgxm+Nj+Q2RfjvjMJPmYfCKqmLylNBppf0zOJAh8miWAI0GrsFuWa0Fw==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v3 0/5] staging: mt7621-spi: Fix C Coding style issues.
Date: Sun,  3 Jun 2018 00:07:26 +0530
Message-Id: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series lists different changes for coding style fixes
as reported by checkpatch.pl, changes can be broken down as :

1. Indent switch and case labels at the same level.
2. Fix a line over 80 columns by refactoring.
3. Use tabs for indentation instead of spaces.
4. Add a space before open paranthesis in switch.
5. Remove unnecessary braces {} from single statement if block.

version 2 changes
- segregated changes in individual commits as per fix category.

version 3 changes
- added unique subjects for each patch in the series.


Sankalp Negi (5):
  staging: mt7621-spi: Indent case labels and switch at the same level.
  staging: mt7621-spi: Fix line over 80 characters by refactoring.
  staging: mt7621-spi: Use tabs for indentation instead of spaces.
  staging: mt7621-spi: Add a space before open paranthesis.
  staging: mt7621-spi: Remove unnecessary braces {} from single
    statement if block.

 drivers/staging/mt7621-spi/spi-mt7621.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.11.0
