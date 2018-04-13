Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeDMR4R convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:56:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeDMR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:56:15 -0400
To: rjw@rjwysocki.net
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [Regression] PCI / PM: Simplify device wakeup settings code
Openpgp: preference=signencrypt
Autocrypt: addr=joseph.salisbury@canonical.com; prefer-encrypt=mutual;
 keydata=
 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
 p24lPxLL08SuCEzuBw==
Cc: lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net
Message-ID: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
Date: Fri, 13 Apr 2018 13:56:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

A kernel bug report was opened against Ubuntu [0].  After a kernel
bisect, it was found that reverting the following two commits resolved
this bug:

0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
 
This is a regression introduced in v4.13-rc1 and still exists in
mainline.  The bug causes the battery to drain when the system is
powered down and unplugged, which does not happed prior to these two
commits.  The bisect actually pointed to commit de3ef1e, but reverting
these two commits fixes the issue.
    
I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue,
or would it be best to submit a revert request?
   
   
Thanks,

Joe

[0] http://pad.lv/1745646
