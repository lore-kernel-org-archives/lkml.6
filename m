Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AG47ELuSVki6lOhB/G8IoOGQh5Iuwvy93mGLxa4tbVdZL87M3Io+kwOUnRzZ7KoU6d7wOtCHnvYt
ARC-Seal: i=1; a=rsa-sha256; t=1520523206; cv=none;
        d=google.com; s=arc-20160816;
        b=C6YtGGnolu7ySoDr5P0KvG72nFjxfyZ5Tt8pcOdN7oqiQ8NBBT5WLo6WmCbUD/X0vM
         /+9JsA6fqn6tYor9uA0kMBJ967mNQFtuBUBDqH5F2AJXGVFGU1mhTbN2d1wqUZkre8i9
         PwEPg0g15B+2X2EvddljXGP2Ui9KXlBwtmCACglgtKIniW1Ui8tT0REpn+2l9+efn0GU
         aGsvSoDHx7Hg0gx/xETa0VFysOpNadwJTmgXRVVd1+nLA9xdBdeCtNMf/wn85KH3prmY
         Br4nWasNAov/BjQykNGuy/dKe4hYds6Xv+iqzAB6c5myibvaODEDYEp8j/EQtF0Wyqy8
         lN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=wEGbpb5gHpNAsT+SeB3d5KGbdlucxZOubNpsb+A+HPY=;
        b=TMN/5wesM2rYVFM1j/aYeZWRtpgwpCNda1ntkZXHEPBM2rn7/yEnjX4vipxLjr7rnD
         MwXJ02JCfc+tpHHuwJlx21sG8klNFLC0qnhluGT/ulSNaw9/wfjLe71eteqQ8U44b0LH
         bp+o5ccO7zIk/UFUVAZuOIYPbPaRmF/XlpiafWr1Q1aTXFvmDZuS75ivrkBTnDvP04sQ
         Y2Jn8C7xVLvF5iYog0nZ55Hjji8d9S32LRpDfiH/9v5Jqg2ZjKX63f4aT1TEmld+mI4Y
         82Gs3DNo6pcUoUOEWppK4fYipZdexytWOGqvpjl0w96NShA38l/pjcwZVSnGYFoHeh0W
         f1Kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5063C2177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLNxsVaMoefYfLi7ow8BjLkipNJwjvXgpEuXZZF8PT6+A@mail.gmail.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
 <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop> <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
 <CAL_JsqLNxsVaMoefYfLi7ow8BjLkipNJwjvXgpEuXZZF8PT6+A@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 8 Mar 2018 09:32:44 -0600
X-Gmail-Original-Message-ID: <CANk1AXQRsAyFOGnUGcdWa0g0SdWu1PD=osYazj3nXJVq8ErABQ@mail.gmail.com>
Message-ID: <CANk1AXQRsAyFOGnUGcdWa0g0SdWu1PD=osYazj3nXJVq8ErABQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
To: Rob Herring <robh@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
	Yves Vandervennet <yves.vandervennet@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783311696826067?=
X-GMAIL-MSGID: =?utf-8?q?1594384141957191333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 7:24 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 7, 2018 at 4:20 PM, Alan Tull <atull@kernel.org> wrote:
>> On Wed, Mar 7, 2018 at 1:47 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
>>>> From: Alan Tull <atull@kernel.org>
>>>>
>>>> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>>>>
>>>> Signed-off-by: Alan Tull <atull@kernel.org>
>>>> ---
>>>> v2: this patch is added in patch set version 2
>>>> ---
>>>>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>> new file mode 100644
>>>> index 0000000..78de689
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>> @@ -0,0 +1,10 @@
>>>> +Intel Stratix10 SoC FPGA Manager
>>>> +
>>>> +Required properties:
>>>> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
>>>> +
>>>> +Example:
>>>> +
>>>> +     fpga_mgr: fpga-mgr@0 {
>>>> +             compatible = "intel,stratix10-soc-fpga-mgr";
>>>
>>> No reg or anything else? Is that because it all goes thru the service
>>> layer firmware?
>>
>> Yes.
>>
>> There will be a few more clients of the service layer: QSPI, Crypto
>> and warm reset.
>>
>>> Just get the service layer driver to instantiate a
>>> device for this driver or get rid of the 2 layers if that's all the
>>> firmware interface does. DT is not a Linux driver instantiation
>>> mechanism.
>>
>> Right, this should be describing hardware.
>>
>> I could add this to the service layer binding:
>>
>> firmware {
>>         svc {
>>                 compatible = "intel,stratix10-svc";
>>                 method = "smc";
>>                 memory-region = <&service_reserved>;
>>                 fpga-mgr {

Actually, add a label.

                  fpga_mgr: fpga-mgr {

>>                         compatible = "intel,stratix10-soc-fpga-mgr";
>
> Still, why do you need this node? If you don't have any other cross
> tree connections, then the service layer can instantiate the
> device(s).

It's used for the FPGA region to know what mgr can program the region.

>
> OTOH, QSPI would need a node because you'll need to describe its bus.
>
> Rob
