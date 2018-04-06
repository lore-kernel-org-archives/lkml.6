Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeDFGvu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:51:50 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34307 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeDFGvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:51:48 -0400
X-Google-Smtp-Source: AIpwx4/oxsKhj4s+y9hT0eD+Z3B8GSonu0rqO713ruoF14FTCz/PZggrlFp8P+g7ae29AB5M1gW+k3oEndGggr1Vuqo=
MIME-Version: 1.0
In-Reply-To: <20180405234632.GA57189@dtor-ws>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
 <20180405132537.3218-4-benjamin.tissoires@redhat.com> <20180405234632.GA57189@dtor-ws>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 6 Apr 2018 08:51:47 +0200
Message-ID: <CAO-hwJKiKPYH30oi45AejPEdNA+=EWM_wiSiQDc0Rj=9X31NXg@mail.gmail.com>
Subject: Re: [PATCH 3/8] Input: elan_i2c - add trackstick report
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 1:46 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Thu, Apr 05, 2018 at 03:25:32PM +0200, Benjamin Tissoires wrote:
>> The Elan touchpads over I2C/SMBus also can handle a
>> trackstick. Unfortunately, nothing tells us if the
>> device supports trackstick (the information lies in
>> the PS/2 node), so rely on a platform data to enable
>> or not the trackstick node.
>
> Hmm, I'd prefer if we did not add more platform data but rather user
> generic device properties.
>

Fair enough, I'll work on it for v2.

Cheers,
Benjamin
