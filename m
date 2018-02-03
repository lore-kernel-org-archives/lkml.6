Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeBCEAO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 23:00:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48125 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeBCEAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 23:00:05 -0500
Subject: Re: [PATCH 2/2] HID: i2c-hid: Fix resume issue on Raydium touchscreen
 device
From: Aaron Ma <aaron.ma@canonical.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>
References: <20180102173006.506-1-aaron.ma@canonical.com>
 <20180102173006.506-2-aaron.ma@canonical.com>
 <CAO-hwJJ3n3YD1+pKvKRRoCX8y-5xZwemKLuLi7aqWSQT=J645A@mail.gmail.com>
 <7ddae302-a44f-b729-c826-082bdcb38d70@canonical.com>
Message-ID: <e8e8a5d2-ee14-54a8-b30b-66d5cc9404b1@canonical.com>
Date: Sat, 3 Feb 2018 11:59:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7ddae302-a44f-b729-c826-082bdcb38d70@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Could anyone review an apply this single patch?

The 2nd patch had been sent as v2.

Regards,
Aaron
