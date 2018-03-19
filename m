Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932952AbeCSM47 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:56:59 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:60516 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932831AbeCSM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:56:56 -0400
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
To: Paolo Abeni <pabeni@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
 <1521462750.3059.12.camel@redhat.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <5468f8eb-17b6-9000-ab4d-a2c67ef35e4b@theobroma-systems.com>
Date: Mon, 19 Mar 2018 13:56:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521462750.3059.12.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.18 13:32, Paolo Abeni wrote:
> Is not clear to me if you can reproduce the bug with the vanilla
> kernel, or if  you need some out-of-tree nic driver. Can you please
> clarify which NIC/driver are you using?

Yes I reproduced it with a vanilla kernel. I use two off-the-shelf USB 
NICs, lsusb says:

   Bus 005 Device 013: ID 0b95:7720 ASIX Electronics Corp. AX88772
   Bus 005 Device 014: ID 0b95:772b ASIX Electronics Corp. AX88772B

Photo of the setup:
https://github.com/jakob-tsd/pfifo_stress/blob/master/usb_nics.jpg

Best regards,
Jakob
