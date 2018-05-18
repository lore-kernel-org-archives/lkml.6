Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeERNPV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:15:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:30095 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbeERNPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:15:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,415,1520924400";
   d="scan'208";a="47678981"
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Hans de Goede <hdegoede@redhat.com>, Chris Chiu <chiu@endlessm.com>
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
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <91f87c43-0ae1-00ec-6b3e-819b639aa1b2@linux.intel.com>
Date: Fri, 18 May 2018 16:15:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba99be8e-8e8b-87c1-8607-24ace8a01c64@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 10:48 AM, Hans de Goede wrote:
> Could it be the i2c input clock definition in drivers/mfd/intel-lpss-pci.c
> is also wrong for Apollo Lake (N3450) ?  There are lots of people having
> various issues with i2c attached touchpads on Apollo Lake devices, this 
> bug:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1728244
> 
> Is sort of a collection bug for these. Various models laptops, lots of
> reporters. Note not sure thie is an i2c-designware issue, but it would
> be good to double check the input clock on Apollo Lake.
> 
Does i2c_designware_core.dyndbg=+p and i2c-hid.debug=1 command line 
arguments give any useful debug information from those machines?

-- 
Jarkko
