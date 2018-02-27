Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeB0VPt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:15:49 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36752 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeB0VPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:15:48 -0500
X-Google-Smtp-Source: AG47ELsHjkWMvf1sNQXwd9UMxwY59QjDKaLwCpHc5CHAe2D7KzKoXCxjN936dbVrr+Xx8rZ8QE+UgQ==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] fujitsu-laptop: Consistent naming of constants
Date: Tue, 27 Feb 2018 22:15:32 +0100
Message-Id: <20180227211539.5708-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is an attempt to organize all the named constants used
throughout fujitsu-laptop so that their names more clearly convey their
purpose: a set of prefixes is introduced to "map" constant names to
call_fext_func() parameters.

The chosen constant naming patterns are a compromise between readability
and enabling longer conditional expressions to fit into the 80-character
line length limit.  Some changes (like those in patches 4/7 and 5/7) may
be perceived as bikeshedding, so please just think of them as proposals,
not fixes.

Finally, patch 7/7 again [1] proposes a set of helper functions which
seem to be making quite a difference in terms of code readability in
certain places (especially in long conditional expressions).  YMMV,
though, feel free to disagree.

This patch series should be applied on top of for-next as it builds on
the previous patch series I submitted.

[1] https://www.spinics.net/lists/platform-driver-x86/msg11633.html

 drivers/platform/x86/fujitsu-laptop.c | 228 +++++++++++++++++++---------------
 1 file changed, 127 insertions(+), 101 deletions(-)

-- 
2.16.2
