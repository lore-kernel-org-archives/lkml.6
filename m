Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeEUGtS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 02:49:18 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:54198 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEUGtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 02:49:13 -0400
X-Google-Smtp-Source: AB8JxZrwBIXx3tCditjvYPB0UpUC93+aBC/kjJ8l8bIfccs7xFhnxURvOZArUl50ckeEHP9NlU1H7JuwEE1Sgfp6pkA=
MIME-Version: 1.0
In-Reply-To: <20180520.183730.1550159916165131561.davem@davemloft.net>
References: <1526679228-1596-1-git-send-email-wang6495@umn.edu> <20180520.183730.1550159916165131561.davem@davemloft.net>
From: Wenwen Wang <wang6495@umn.edu>
Date: Mon, 21 May 2018 01:48:31 -0500
X-Gmail-Original-Message-ID: <CAAa=b7f3LA4GS18VfLouDLFYAsGifwbWb1DtMeWSGOCT64egug@mail.gmail.com>
Message-ID: <CAAa=b7f3LA4GS18VfLouDLFYAsGifwbWb1DtMeWSGOCT64egug@mail.gmail.com>
Subject: Re: [PATCH v2] isdn: eicon: fix a missing-check bug
To: David Miller <davem@davemloft.net>
Cc: Kangjie Lu <kjlu@umn.edu>, Armin Schindler <mac@melware.de>,
        Karsten Keil <isdn@linux-pingi.de>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4L6nPUX016114

On Sun, May 20, 2018 at 5:37 PM, David Miller <davem@davemloft.net> wrote:
> From: Wenwen Wang <wang6495@umn.edu>
> Date: Fri, 18 May 2018 16:33:47 -0500
>
>> In divasmain.c, the function divas_write() firstly invokes the function
>> diva_xdi_open_adapter() to open the adapter that matches with the adapter
>> number provided by the user, and then invokes the function diva_xdi_write()
>> to perform the write operation using the matched adapter. The two functions
>> diva_xdi_open_adapter() and diva_xdi_write() are located in diva.c.
>
> This doesn't even compile:
>
> In file included from drivers/isdn/hardware/eicon/divasmain.c:30:
> drivers/isdn/hardware/eicon/diva.h:23:18: error: unknown type name ‘diva_xdi_um_cfg_cmd_t’
>       int length, diva_xdi_um_cfg_cmd_t *msg,
>                   ^~~~~~~~~~~~~~~~~~~~~
> drivers/isdn/hardware/eicon/diva.h:27:20: error: unknown type name ‘diva_xdi_um_cfg_cmd_t’
>         int length, diva_xdi_um_cfg_cmd_t *msg,
>                     ^~~~~~~~~~~~~~~~~~~~~

Sorry. I will correct the compilation errors and resubmit the patch.

Wenwen
