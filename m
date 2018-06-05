Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeFEVZt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbeFEVZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:25:47 -0400
X-Google-Smtp-Source: ADUXVKJMNq8g/Nd0Hyq1nO2J+F5pVrsTXpVL2yfJlElDn6eEXCajeEwubcqVwEUhQXd51U4gHSixDZ8ip1lkpB+ecks=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-12-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-12-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 5 Jun 2018 16:25:05 -0500
X-Gmail-Original-Message-ID: <CANk1AXRhsTKHJfVBPQL5PwXQF=Tvb_y+V3uE8AicgFrzKZse3A@mail.gmail.com>
Message-ID: <CANk1AXRhsTKHJfVBPQL5PwXQF=Tvb_y+V3uE8AicgFrzKZse3A@mail.gmail.com>
Subject: Re: [PATCH v5 11/28] fpga: dfl: add dfl_fpga_check_port_id function.
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> This patch adds one common function in DFL framework. It uses
> port_ops get_id callback to get port id and compare it with given
> value. This function could be used as match function of the
> dfl_fpga_cdev_find_port function.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
