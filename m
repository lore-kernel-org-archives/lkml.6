Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755012AbeCVNkj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:40:39 -0400
Received: from hermes.apache.org ([140.211.11.3]:55007 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751753AbeCVNkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:40:36 -0400
Message-ID: <d9fd167d6661fe4311eb773d794de8b22496b67a.camel@apache.org>
Subject: Re: [PATCH v3] Fix modifier keys for Redragon Asura Keyboard
From: Robert Munteanu <rombert@apache.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date: Thu, 22 Mar 2018 14:40:31 +0100
In-Reply-To: <1b0047c60fc5dc4be4bbe627ab830e65db1cfae5.camel@apache.org>
References: <20180321104331.22783-1-rombert@apache.org>
         <201803211751.04734.linux@rainbow-software.org>
         <1b0047c60fc5dc4be4bbe627ab830e65db1cfae5.camel@apache.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 09:17 +0100, Robert Munteanu wrote:
> On Wed, 2018-03-21 at 17:51 +0100, Ondrej Zary wrote:
> > On Wednesday 21 March 2018 11:43:31 Robert Munteanu wrote:
> > > +#define USB_VENDOR_ID_MICRODIA          0x0c45
> > > +#define USB_DEVICE_ID_REDRAGON_ASURA    0x760b
> > 
> > Microdia is most probably an incorrect name. The 0c45 id probably
> > belongs 
> > to "Sonix Technology Co., Ltd."
> 
> Right, I was unsure about that. I'll remove the microdia references
> and
> use sonix.

I see the following in hid-ids.h

  define USB_VENDOR_ID_JESS            0x0c45

which I guess I should use since it's already defined in there.

Robert
