Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeB0Xzr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:55:47 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:42924 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeB0Xzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:55:46 -0500
X-Google-Smtp-Source: AG47ELuEK9qU1bTdelKqv7n6yaY0VmVNRTjuZG9gtHD3M2OiDpdMS6cuAY9bblrSUEyO3QI+f3QH9Q==
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: Regression in IPMI on 4.15.6
Message-ID: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
Date: Tue, 27 Feb 2018 15:55:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora got a bug report of a crash in IPMI on 4.15.6
https://bugzilla.redhat.com/show_bug.cgi?id=1549316
Unfortunately, it's only a screenshot but it's fairly
clear. It looks like a panic in the error handling path
in platform_device_unregister. Any ideas?

Thanks,
Laura
