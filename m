Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeFESQn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:16:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40760 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFESQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:16:41 -0400
X-Google-Smtp-Source: ADUXVKIbDayLIp4KUTtF5X9akhxWB845oImencEanbZzS/ZRMS0STiwu9v4nfemuHq1kkcSGd6emsD/+NMYGTO5ZBH4=
MIME-Version: 1.0
In-Reply-To: <7085d0bb-557c-0796-d3ae-756e000a7950@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-6-enric.balletbo@collabora.com> <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
 <7085d0bb-557c-0796-d3ae-756e000a7950@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Jun 2018 15:16:40 -0300
Message-ID: <CAOMZO5Cod=jo5gC1ibQx5ZHU5xtUZDvfZt899=nPLgH4bhy+_g@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Jun 5, 2018 at 3:14 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:

> Right, but the module license is set to GPL which means GNU Public License v2 or
> later, see [1]. So, there is a mismatch. In such cases I assumed GPL-2.0+ as the
> default. These mismatches are common so I think that should be fine for the
> authors, if someone is disagree just let me know and I will change.

Ok, but I think you should add this explanation in the commit log to
make it clearer.
