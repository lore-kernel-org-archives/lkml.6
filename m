Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCMAH5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:07:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46628 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeCMAH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:07:56 -0400
X-Google-Smtp-Source: AG47ELsvVNOiy2IC8LbfY56Cz2OaAvgXYWiA4EU/QZHVA7bl4soiEnHcjmaRuG++4IxYiu45RbG0Iw==
Date: Tue, 13 Mar 2018 01:07:37 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: w@1wt.eu, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Doc: misc-devices: move lcd-panel-cgram.txt to auxdisplay/
Message-ID: <20180313000737.aybluy746piwyzll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7005b58458e4beecaf5efacb872c456bc7d3541a ("Staging: add lcd-panel
driver") introduced the panel driver, which is now in
drivers/auxdisplay.

Cc: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Documentation/{misc-devices => auxdisplay}/lcd-panel-cgram.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{misc-devices => auxdisplay}/lcd-panel-cgram.txt (100%)

diff --git a/Documentation/misc-devices/lcd-panel-cgram.txt b/Documentation/auxdisplay/lcd-panel-cgram.txt
similarity index 100%
rename from Documentation/misc-devices/lcd-panel-cgram.txt
rename to Documentation/auxdisplay/lcd-panel-cgram.txt
-- 
2.14.1
