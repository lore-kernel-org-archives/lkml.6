Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeBIQ5R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:57:17 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33067 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeBIQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:57:15 -0500
X-Google-Smtp-Source: AH8x227m6j353Bwi3KbWbUzNekTXDoh8xGskkqQPJZhtjnUeltmPnty1mgzMbMmt7T87mmlnMjgt/VEEGNBUMfkylt4=
MIME-Version: 1.0
In-Reply-To: <HE1PR0802MB23312984E1ED38FB103A902D9CF20@HE1PR0802MB2331.eurprd08.prod.outlook.com>
References: <HE1PR0802MB23312984E1ED38FB103A902D9CF20@HE1PR0802MB2331.eurprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Feb 2018 08:57:14 -0800
Message-ID: <CAPcyv4ihg3Ym09mbNxzTBjy5Mq3arYAuQB=oGddzAhU1tQeMEg@mail.gmail.com>
Subject: Re: linux-4.15 bug report
To: David Binderman <dcb314@hotmail.com>
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 7:33 AM, David Binderman <dcb314@hotmail.com> wrote:
> Hello there,
>
> linux-4.15/drivers/dma/ppc4xx/adma.c:3797]: (warning) Redundant assignment of 'adev->common.cap_mask' to itself.
>
> Source code is
>
>        adev->common.cap_mask = adev->common.cap_mask;
>
> Suggest either remove the code or do something useful.

Thanks for the report, Please send a patch.
