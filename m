Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeDDMev (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:34:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751167AbeDDMet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:34:49 -0400
Message-ID: <1522845288.2606.3.camel@redhat.com>
Subject: Re: [PATCH] net: improve ipv4 performances
From: Paolo Abeni <pabeni@redhat.com>
To: Anton Gary Ceph <agaceph@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2018 14:34:48 +0200
In-Reply-To: <20180401183121.13022-1-agaceph@gmail.com>
References: <20180401183121.13022-1-agaceph@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-01 at 20:31 +0200, Anton Gary Ceph wrote:
> After a few profiling and analysis, turned out that the ethertype field
> of the packets has the following distribution:
[...]
>      0.6% don't know/no opinion

Am I the only one finding the submission date and the above info
suspicious ?!?

/P
