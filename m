Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeE2Oe4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934608AbeE2Oez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:34:55 -0400
X-Google-Smtp-Source: ADUXVKJOtlQdl7tGXjatZOKPbJcj4we6K5CLHcUW54fGFOSeDgL/DE3iZqlFWvaO+jTaAfXzz82OyHhZ+Fcb8szfh3g=
MIME-Version: 1.0
In-Reply-To: <20180528100058.705378203@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org> <20180528100058.705378203@linuxfoundation.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 May 2018 09:34:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzkv3Vx_sjhY1fej7adVQZz578E4EGXZuOUWVoQzoJJw@mail.gmail.com>
Message-ID: <CAL_JsqJzkv3Vx_sjhY1fej7adVQZz578E4EGXZuOUWVoQzoJJw@mail.gmail.com>
Subject: Re: [PATCH 3.18 093/185] microblaze: switch to NO_BOOTMEM
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 5:02 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Rob Herring <robh@kernel.org>
>
> [ Upstream commit 101646a24a2f9cdb61d7732459fbf068a7bbb542 ]
>
> Microblaze doesn't set CONFIG_NO_BOOTMEM and so memblock_virt_alloc()
> doesn't work for CONFIG_HAVE_MEMBLOCK && !CONFIG_NO_BOOTMEM.

Unless Michal feels differently, I don't think this should go in
stable. The DT change that broke microblaze is only in 4.16 .

Rob
