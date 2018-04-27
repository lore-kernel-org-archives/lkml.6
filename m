Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeD0Kjs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:39:48 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33239 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbeD0Kjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:39:47 -0400
X-Google-Smtp-Source: AB8JxZph6FT2Z1B82ae1DeVtx/PoVgbUhum7kRLD0XlccqKyS4Jmd+cjgdPOTKJPvrp5wl51oAe4wA==
From: Holger Schurig <holgerschurig@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
In-Reply-To: <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
References: <87h8o0ocul.fsf@gmail.com> <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com> <877eovobxl.fsf@gmail.com> <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com> <87wowumj21.fsf@gmail.com> <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
Date: Fri, 27 Apr 2018 12:39:42 +0200
Message-ID: <87o9i53pch.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> The first are the following 2 lines from your dump:
> Apr 26 10:42:49 kernel: igb 0000:02:00.0 eth0: igb: eth0 NIC Link is
> Up 1000 Mbps Half Duplex, Flow Control: RX
> Apr 26 10:42:49 kernel: igb 0000:02:00.0: EEE Disabled: unsupported at
> half duplex. Re-enable using ethtool when at full duplex.

Can it be the case that this is just a follow-up error?

In one of the mails from yesterday I showed you my patch to disable 1000
MB/s ... and still I had the link-always-down.

Similarly when I used a 10/100 MB/s switch only.

Both scenarios disabled 1000 MB/s, one more strictly than the other :-)
