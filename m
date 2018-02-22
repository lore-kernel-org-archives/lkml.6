Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBVFOJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:14:09 -0500
Received: from a8-242.smtp-out.amazonses.com ([54.240.8.242]:56710 "EHLO
        a8-242.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbeBVFOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:14:08 -0500
To: Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marco Martin <notmart@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jeremy Cline <jeremy@jcline.org>
Subject: Regression: Dell XPS 13 9360 keyboard no longer works
Message-ID: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
Date: Thu, 22 Feb 2018 05:14:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.02.22-54.240.8.242
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Commit 30323fb6d552c41997baca5292bf7001366cab57 (Support tablet mode
switch) causes the keyboard on my XPS 13 to stop working. This
particular model has a touch screen (which I've disabled in the BIOS),
but isn't a 2-in-1 with a tablet mode. My guess is it's being put in
tablet mode and that's disabling the keyboard? In any case, I'm happy
to test fixes and provide any necessary information.

Regards,
Jeremy
