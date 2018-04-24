Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756773AbeDXLET (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:04:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47901 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeDXLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:04:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180424110414euoutp01580da176995169fa0b098cb058e84317~oWmLRAfW01015110151euoutp01g
X-AuditID: cbfec7f5-b5fff700000028a9-1c-5adf0f2beae2
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 10/15] ata: pata_pxa: remove the dmaengine compat need
Date: Tue, 24 Apr 2018 13:04:07 +0200
Message-ID: <2592887.EUCMT0tEEq@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <87sh7oxsn8.fsf@belgarion.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzneV1t/vtRBiuOaln8nXSM3WLT42us
        Fsd2PGKyuLxrDpvFrDfCDqwev39NYvToX/eZ1WPzknqPz5vkAliiuGxSUnMyy1KL9O0SuDLu
        Hf3JXnCDteLypX6WBsYrLF2MHBwSAiYSj8/HdzFycggJrGCUuP/bsYuRC8j+wiix4MpqRgjn
        M6NEx547rCBVIA1NJ2+xQSSWM0ocautmhXA+MEqsPjWbEaSKTcBKYmL7KkaQFSIC2hI3t/mD
        1DALNDFKvHu6mwmkRljAS6Lpzzd2EJtFQFXiz+W9bCA2r4CmxMl3y5hBbFGgmi372sHqOQV0
        JFa+fsYKUSMocXLmExYQm1lAXqLjciPYERIC7ewSe+/uZII41UXi6o8TLBC2sMSr41vYIWwZ
        idOTe1ggGpoZJb7t2MMMkZjAKLFnvRCEbS1x+PhFVpAPmIEuWr9LHyJsK3Fm6Vc2SNjxSdx4
        KwhxA5/EpG3TmSHCvBIdbVBD1CQ2LNvABrO1a+dKqBIPif6X0hMYlWYheWYWkmdmIaxdwMi8
        ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCJnP53/OsOxn1/kg4xCnAwKvHw/vh9N0qI
        NbGsuDL3EKMEB7OSCO9euXtRQrwpiZVVqUX58UWlOanFhxilOViUxHnjNOqihATSE0tSs1NT
        C1KLYLJMHJxSDYybDT/o/tuY0mX8qHeRTI+iYcrceTb3zijNzRTVeOcadPpAa/DErPml7Rsi
        DU6t9p1yx+OHVNWyX0cOzoqtXP3/3f5Tx4W4M4T+bgl60vX2t0zIVrP7Z3YZ2W3eF/yrYIfu
        hsfb7y+RdakTDjj+/PtzVVMdpsPLNLfzPki7zfMibGXIi1oHczMzJZbijERDLeai4kQAuf1t
        QB4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7pa/PejDLZuYrf4O+kYu8Wmx9dY
        LY7teMRkcXnXHDaLWW+EHVg9fv+axOjRv+4zq8fmJfUenzfJBbBE6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXcO/qTveAGa8XlS/0sDYxXWLoY
        OTkkBEwkmk7eYuti5OIQEljKKDHtey9jFyMHUEJG4vj6MogaYYk/17qgat4xSiw9dZwNJMEm
        YCUxsX0VWL2IgLbEzW3+IGFmgQZGiU8bw0BsYQEviaY/39hBbBYBVYk/l/eCtfIKaEqcfLeM
        GcQWBarZsq+dCcTmFNCRWPn6GSvErrWMErtfX2OCaBCUODnzCQvEAnmJjsuNrBC2jsSC3Z/Y
        JjAKzkJSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERsi2Yz+37GDsehd8
        iFGAg1GJh/fH77tRQqyJZcWVuYcYJTiYlUR498rdixLiTUmsrEotyo8vKs1JLT7EaAr03URm
        KdHkfGD05pXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYFTad/l+
        0YXVB9UNa/dxSH0uOtOwmNltTrPO4Y1P7O0Dnt1/lVK9Ua/YbIPfNyVnxth0tY6U3rviv0Ju
        /PN84xvs1Kd70db4cbXwn+KZ97jZ/O/92zPhWu0SkdK9/N1as+wKeyPlHTm8mRY8f96XKfKC
        ffnK/NLMgO/sBRHzc7au+twpPOeHoxJLcUaioRZzUXEiANZgVjmmAgAA
X-CMS-MailID: 20180424110410eucas1p23be5bb2327efdf30271ba209fb842c64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424110410eucas1p23be5bb2327efdf30271ba209fb842c64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180421193220epcas1p37073b0047d529bcc888233af6200ae35
X-RootMTR: 20180421193220epcas1p37073b0047d529bcc888233af6200ae35
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <CGME20180421193220epcas1p37073b0047d529bcc888233af6200ae35@epcas1p3.samsung.com>
        <87sh7oxsn8.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 21, 2018 09:32:11 PM Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > As the pxa architecture switched towards the dmaengine slave map, the
> > old compatibility mechanism to acquire the dma requestor line number and
> > priority are not needed anymore.
> >
> > This patch simplifies the dma resource acquisition, using the more
> > generic function dma_request_slave_channel().
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Bartlomiej, could I have your ack please ?

Sure.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
