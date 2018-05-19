Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeESL7C (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:59:02 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36250 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:58:58 -0400
X-Google-Smtp-Source: AB8JxZoG1eyr2p5HiqqTgtqZdBOw8iSSo839kx1l4LR/sbhWvHciSCmrw1ErxHdAVrHjX9AOrAEAIg==
From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chris Chiu <chiu@endlessm.com>
Cc: Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
 <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
 <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
 <CAD8Lp46b+-B=xqSAqB+zV4xF6SRUGs46FkydS37UEuqav_jNog@mail.gmail.com>
 <CAB4CAwd0tN7CaS7YZCo3TZH-DPxt0x6wxyO23v7aBW9MOCtHCw@mail.gmail.com>
 <c1343704-6b1a-14b5-3942-a8a33f73feee@linux.intel.com>
 <CAB4CAwe6kjJ10s0KtVJrPMSC8UA+YLCiqbnkZ_-oFTKTFPTwCw@mail.gmail.com>
 <7728da79-8a7a-b87d-d09c-b36978b3032e@linux.intel.com>
 <a3ce1af5-7b99-38db-fc51-4d580db1e87e@linux.intel.com>
 <ba99be8e-8e8b-87c1-8607-24ace8a01c64@redhat.com>
 <91f87c43-0ae1-00ec-6b3e-819b639aa1b2@linux.intel.com>
Message-ID: <f52aa2eb-0af4-dac5-11d4-40b1379b5f89@redhat.com>
Date: Sat, 19 May 2018 13:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <91f87c43-0ae1-00ec-6b3e-819b639aa1b2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-05-18 15:15, Jarkko Nikula wrote:
> On 05/18/2018 10:48 AM, Hans de Goede wrote:
>> Could it be the i2c input clock definition in drivers/mfd/intel-lpss-pci.c
>> is also wrong for Apollo Lake (N3450) ?  There are lots of people having
>> various issues with i2c attached touchpads on Apollo Lake devices, this bug:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1728244
>>
>> Is sort of a collection bug for these. Various models laptops, lots of
>> reporters. Note not sure thie is an i2c-designware issue, but it would
>> be good to double check the input clock on Apollo Lake.
>>
> Does i2c_designware_core.dyndbg=+p and i2c-hid.debug=1 command line arguments give any useful debug information from those machines?

A first dmesg with these flags has been provided:
https://launchpadlibrarian.net/370884912/dmesg.log

Regards,

Hans
