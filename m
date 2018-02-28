Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964799AbeB1W6n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:58:43 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35462 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeB1W6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:58:41 -0500
X-Google-Smtp-Source: AG47ELtqEYbaSEUZc4/waF6yFgEvSI+9vppKeFzRnurrek4v4YNE1b6DydZsNoEwkgfHFNngq0NoD+RPvY7po5xa3W0=
MIME-Version: 1.0
In-Reply-To: <1519769819.23791.19.camel@wdc.com>
References: <1519769278-20094-1-git-send-email-hernan@vanguardiasur.com.ar> <1519769819.23791.19.camel@wdc.com>
From: =?UTF-8?Q?Hern=C3=A1n_Gonzalez?= <hernan@vanguardiasur.com.ar>
Date: Wed, 28 Feb 2018 19:58:20 -0300
Message-ID: <CALfa3vGLja=CvkK-L+9CV9seF9C=jUkBR9p46bWb4oO1vFkgcg@mail.gmail.com>
Subject: Re: [PATCH] IB/rxe: Remove unused variable (char *rxe_qp_state_name[])
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1SMwosL027956

On Tue, Feb 27, 2018 at 7:17 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Tue, 2018-02-27 at 19:07 -0300, Hernán Gonzalez wrote:
>> Note: This is compile only tested as I have no access to the hw.
>
> Hello Hernán,
>
> Are you aware that the only hardware that is needed to test this driver is
> an Ethernet interface, and that this driver even supports the loopback
> interface?
>
> Bart.
>

Hello Bart,

No, I didn't know, sorry about that. I'll test it as soon as I can.
Thanks for the response.

Cheers,
Hernán
