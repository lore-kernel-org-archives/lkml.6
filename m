Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425349AbeCBJGs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:06:48 -0500
Received: from mail1.bemta5.messagelabs.com ([195.245.231.147]:29418 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424685AbeCBJGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:06:31 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsUSt3Opsa6oyMw
  ogyXN6hbt75axW1zeNYfN4tjqK2wOzB7z1lR7fN4kF8AUxZqZl5RfkcCa8f5zH3PBGY6Kq3d3
  sDUw/mPrYuTiEBJYwiix6fAE5i5GTg42AUOJeW/eM4LYIgKmEq2Nu4CKODiYBaoltp5KBwkLC
  1hJzHx3kg2ixFri1ou9rBC2kcSDrd/AxrAIqEhs79jBDmLzCgRIPPs4DaxeSKBY4vfPs2D1nA
  J6EruffASzGQVkJb40rgbrZRYQl7j1ZD4TiC0hICCxZM95ZghbVOLl43+sELa8xM1Xx1ggbHu
  J1/fesYCcKSGgL9HXWAwRNpRYNe0AVNhcYk+fH8R0HYkFuz+xQdjaEssWvmaGuFJQ4uTMJywT
  GMVnITliFpKWWUhaZiFpWcDIsopRvTi1qCy1SNdQL6koMz2jJDcxM0fX0MBULze1uDgxPTUnM
  alYLzk/dxMjMOLqGRgYdzA29TofYpTkYFIS5fV7MSNKiC8pP6UyI7E4I76oNCe1+BCjDAeHkg
  RvpPDMKCHBotT01Iq0zBxg7MOkJTh4lER4i4SA0rzFBYm5xZnpEKlTjLocN168bmMWYsnLz0u
  VEudlBJkhAFKUUZoHNwKWhi4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEua1AZnCk5lXArfp
  FdARTEBHsL+dAXJESSJCSqqBcWasmgy/a6Bgma/qu+bgzpJv4sWJG/foSLh7ly/aN61XObOGh
  YFffe3j/WeyE75xnt+nH/6fZcF//79+b04uShVtYt4W18/E6HfWp5rpZMNnBjbBMxxPNgqJZH
  YtmvAvcBHHBCWvp34S/KemfLC8eVtSv3uFLf/85XJZsi8qmXr61DV2sc1WYinOSDTUYi4qTgQ
  AuZ/Zkj4DAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-15.tower-179.messagelabs.com!1519981589!91298751!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH 000/100] rtc: remove cargo culted code
Thread-Topic: [PATCH 000/100] rtc: remove cargo culted code
Thread-Index: AQHTsgRrMfKkTUePSE2lYWgsuyEkTKO8prJA
Date: Fri, 2 Mar 2018 09:06:28 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70194158130@SW-EX-MBX01.diasemi.com>
References: <6ED8E3B22081A4459DAC7699F3695FB701941570C7@SW-EX-MBX01.diasemi.com>
 <20180302085654.GA1479@piout.net>
In-Reply-To: <20180302085654.GA1479@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.26.49]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 02/03/2018 08:05:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 March 2018 08:57, Alexandre Belloni wrote:

> To: Steve Twiss
> Cc: linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org
> Subject: Re: [PATCH 000/100] rtc: remove cargo culted code
> 
> On 02/03/2018 at 08:46:48 +0000, Steve Twiss wrote:
> > Hi Alexandre,
> >
> > Acked for:
> >   rtc: da9063: stop validating rtc_time in .read_time
> >   rtc: da9052: stop validating rtc_time in .read_time
> >   rtc: da9055: stop validating rtc_time in .read_time
> >
> > Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >

[...]

> > But after some further looking, I have not got any explicit case of how the
> > time read directly from the DA9063
> > registers can be incorrectly represented. So there should be no need to
> > check this.
> 
> My point is that it is checked later in the core anyway so you end up
> doing:
> 
> da9063_rtc_read_time()
> 	return rtc_valid_tm(tm);
> 
> __rtc_read_time()
> 	if (err < 0)
> 		return err;
> 	err = rtc_valid_tm(tm);
> 
> 	return err;
> 
> So the check in da9063_rtc_read_time is always pointless.

Ahh. I see. Thanks!
Regards,
Steve
