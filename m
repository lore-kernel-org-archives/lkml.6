Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbeDTSCW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:02:22 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36108 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeDTSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:02:20 -0400
X-Google-Smtp-Source: AIpwx4+cNKBD+X67J5J+G0PPvPH8NEOcM13atq/Dka35BowlMOyn0V7ampkFMg0LRXYldwjKNipGPUmCFZQo/7NMrGg=
MIME-Version: 1.0
In-Reply-To: <CAH2r5mtYQujfeEUpEiE557o3YccD9QwWCTLCJFbBoF7zbYcggQ@mail.gmail.com>
References: <20180420131919.GA1766@embeddedor.com> <CAH2r5mtYQujfeEUpEiE557o3YccD9QwWCTLCJFbBoF7zbYcggQ@mail.gmail.com>
From: Pavel Shilovsky <piastryyy@gmail.com>
Date: Fri, 20 Apr 2018 11:02:17 -0700
Message-ID: <CAKywueQ0rd6iJPPS7Z4r_1NU9Er9rnjLEprLwJ-U5g-em3tfKQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: dir: fix memory leak in cifs_mknod
To: Steve French <smfrench@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Colin King <colin.king@canonical.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-20 10:37 GMT-07:00 Steve French <smfrench@gmail.com>:
> I noticed a similar problem with the tcon link leak on that (which
> Colin and Gustavo pointed out - thank you!) but also in another return
> statement, so updated the original patch of Ronnie's merging the fixes
>
> https://git.samba.org/sfrench/cifs-2.6.git/?p=sfrench/cifs-2.6.git;a=commit;h=167bc5de08dc97695f9d5c7069c3e69f409ff80b
>
>
> Let me know if you see any problems with it.
>

Looks good.

Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>

--
Best regards,
Pavel Shilovsky
