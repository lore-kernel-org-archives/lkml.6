Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeFES3Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:29:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39585 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFES3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:29:23 -0400
X-Google-Smtp-Source: ADUXVKJTzYZujJ6As9UAzwhgNl9FbtnLuiYouhf+Qpgfqgazpxa1zjYrk7iR36yYpkBKuxvz2/+AFw==
Date: Tue, 5 Jun 2018 11:29:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
Message-ID: <20180605182919.GF202428@dtor-ws>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-6-enric.balletbo@collabora.com>
 <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
 <7085d0bb-557c-0796-d3ae-756e000a7950@collabora.com>
 <CAOMZO5Cod=jo5gC1ibQx5ZHU5xtUZDvfZt899=nPLgH4bhy+_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cod=jo5gC1ibQx5ZHU5xtUZDvfZt899=nPLgH4bhy+_g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:16:40PM -0300, Fabio Estevam wrote:
> Hi Enric,
> 
> On Tue, Jun 5, 2018 at 3:14 PM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> 
> > Right, but the module license is set to GPL which means GNU Public License v2 or
> > later, see [1]. So, there is a mismatch. In such cases I assumed GPL-2.0+ as the
> > default. These mismatches are common so I think that should be fine for the
> > authors, if someone is disagree just let me know and I will change.
> 
> Ok, but I think you should add this explanation in the commit log to
> make it clearer.

If there is a conflict between the license notice and MODULE_LICENSE()
we should go by the license notice. The license note is usually approved
by companies, whereas MIODULE_LICENSE()s get moved, adjusted, etc.

For ChromeOS kernel changes license notice is GPL v2 as documented at:

https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/kernel-faq

section "Which copyright header should I use?"

Thanks.

-- 
Dmitry
