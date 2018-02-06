Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeBFAjd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:39:33 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44625 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeBFAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:38:49 -0500
X-Google-Smtp-Source: AH8x2270d8HddkyM6mGubSqHfsWsrpRpJ42YITGqLIGOCoZohSdsDHbH18fxNDUKkCIMuSD3S2PdmiZgHYvAbtM/Bp0=
MIME-Version: 1.0
In-Reply-To: <20180115104316.k7xsu3qnnmzvlkpd@earth.universe>
References: <20180112150744.sjntmpas5noaub6g@earth.universe>
 <CAOMZO5BpJDoeZVaD+c600ci5rmEJ0kh_er1voJxsyXR4BdjFpw@mail.gmail.com> <20180115104316.k7xsu3qnnmzvlkpd@earth.universe>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2018 22:38:47 -0200
Message-ID: <CAOMZO5BVdF+LaqHf-buCTL+gLfukEKc5Et=5=3=AJqSNZvXhbA@mail.gmail.com>
Subject: Re: Regression due to "PCI: Do not allocate more buses than available
 in parent"
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Jan 15, 2018 at 8:43 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

>> Does this patch fix the problem?
>> https://patchwork.ozlabs.org/patch/857566/
>
> Yes, that fixes the issue. Thanks for the hint.

Could you please reply to that patch with your Tested-by tag?

Thanks
