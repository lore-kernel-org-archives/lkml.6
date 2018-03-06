Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeCFQA6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:00:58 -0500
Received: from a8-62.smtp-out.amazonses.com ([54.240.8.62]:53348 "EHLO
        a8-62.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932112AbeCFQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:00:54 -0500
From: Jeremy Cline <jeremy@jcline.org>
Subject: Regression from efi: call get_event_log before ExitBootServices
To: Thiebaud Weksteen <tweek@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-ID: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
Date: Tue, 6 Mar 2018 16:00:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.03.06-54.240.8.62
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Commit 33b6d03469b2 ("efi: call get_event_log before ExitBootServices")
causes my GP-electronic T701 tablet to hang when booting. Reverting the
patch series or hiding the TPM in the BIOS fixes the problem.

I've never fiddled with TPMs before so I'm not sure what what debugging
information to provide. It's got an Atom Z3735G and the UEFI firmware is
InsydeH20 version BYT70A.YNCHENG.WIN.007.


Regards,
Jeremy
