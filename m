Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDEXqi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:46:38 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34993 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDEXqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:46:36 -0400
X-Google-Smtp-Source: AIpwx49SPd4lvqEwAMPUsCva5nXxBWelQ2+yXK+0DmEoomBMeMaQ/gY/cPR3PZHir0dsMR9s+DGK1Q==
Date: Thu, 5 Apr 2018 16:46:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] Input: elan_i2c - add trackstick report
Message-ID: <20180405234632.GA57189@dtor-ws>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
 <20180405132537.3218-4-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405132537.3218-4-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Apr 05, 2018 at 03:25:32PM +0200, Benjamin Tissoires wrote:
> The Elan touchpads over I2C/SMBus also can handle a
> trackstick. Unfortunately, nothing tells us if the
> device supports trackstick (the information lies in
> the PS/2 node), so rely on a platform data to enable
> or not the trackstick node.

Hmm, I'd prefer if we did not add more platform data but rather user
generic device properties.

Thanks.

-- 
Dmitry
