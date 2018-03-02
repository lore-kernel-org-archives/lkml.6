Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163736AbeCBA2A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:28:00 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:33538 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163255AbeCBA16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:27:58 -0500
X-Google-Smtp-Source: AG47ELudOTHwNhJhPjnkaqP5pBXMOVISD0EOuNcSwO6NWYxe8mRGhzyHAJ9rjO9b9ePij2VkFCCZChPxJmc/FTZpjI8=
MIME-Version: 1.0
In-Reply-To: <20180301182436.GI12864@sirena.org.uk>
References: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
 <20180301182436.GI12864@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Mar 2018 21:27:57 -0300
Message-ID: <CAOMZO5CnePJqXnb_14FaWxjx0AC4oT0m_SqFtwPjwjskquSYPw@mail.gmail.com>
Subject: Re: regmap: Failed to create debugfs directory
To: Mark Brown <broonie@kernel.org>
Cc: brgl@bgdev.pl, david@lechnology.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Mar 1, 2018 at 3:24 PM, Mark Brown <broonie@kernel.org> wrote:

> Is this triggered by 9b947a13e7f6017f18 (regmap: use debugfs even when
> no device)?

Yes, exactly. If I revert this commit the warnings are gone.

Should I send a revert or is there another way to solve it?

Thanks
