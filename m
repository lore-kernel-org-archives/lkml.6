Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeCBU5n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:57:43 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:37686 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932896AbeCBU5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:57:42 -0500
X-Google-Smtp-Source: AG47ELsSxtTetbx/f7oPk1VW/7hyTuylmOS7ApWQycjwLYWg7I9bcwafyXMVxIaubl22eMePteLuSQ==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc: linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: "x86/boot/compressed/64: Prepare trampoline memory" breaks boot on
 Zotac CI-321
Message-ID: <12357ee3-0276-906a-0e7c-2c3055675af3@gmail.com>
Date: Fri, 2 Mar 2018 21:57:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently my Mini PC Zotac CI-321 started to reboot immediately before
anything was written to the console.

Bisecting lead to b91993a87aff "x86/boot/compressed/64: Prepare
trampoline memory" being the change breaking boot.

If you need any more information, please let me know.

Rgds, Heiner
