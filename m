Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AH8x226PPS5eAWTmSqDyHUI+LPyll6NkbLQW5oNGiaRn5V5PK+aknIOOLTJuP8Kq9RofAA2O39Li
ARC-Seal: i=1; a=rsa-sha256; t=1517480869; cv=none;
        d=google.com; s=arc-20160816;
        b=l3tc/TKeyj4xFSa0MBmYX8MqFduj0W8BbEoHBQ7H47Jv5tAGuawdvCgMITCaWxypsI
         A5i1erpEyT78b9nx/pBLsQYwANSZ1sABQ52Dz9ptOcIpD9tcaMqww/PVJHRn1jp8lIVb
         7STuyNXTz5Gjw3HvmAloWA+1H9uFjvXByphV4H7rHnyiVX7OdIhzGL4YErf+MO4qYKBJ
         /cl9ZkqUGN2JUuqP1cIQkCg+nei1xR9TH/WCp+UUztAdouqkcGVFjBGzVnTO+IyLUFLr
         A1+tZFaMiNURioM1M1tzeqifdyJIEn4ZTdtfRfP1r1QUm5dzSQSocc9dZRRXHMwLXKPD
         kaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Kims0cGNV0JxFUXLdvUqg5C1LE77i5dbgDnNy+eWaTI=;
        b=T5pJ8Y+7k9JAEaxDUUuUvcSqSZqPYsnu2Qj76x/WZ/msErFNIyZ8UrZnv/D9/gWus3
         2s6f3jkrIzja6Zy1SyqpNlK32WxsTK6mSpxOy5i+BR8rFFSaYMs5yoHglgxQRqkIm9/T
         wgRJz8VhO/c8e520HR1Jc3P4Yg2908PD9pCGr4ddwmiPKcGANX3CQdHUlCbWnypSKGW2
         nc2V1hDa3SBYt6uEOd182Ax9jhjNYUwGpFu5OC4NVxA/vUnZOCBMSsqxf8e1CjdSefIe
         pOsztKm4cZvVvi89Uv4QlcaNY2S7wNKuvg5qyuscgsuf65rcH7TzxnqtmskbnVv/Ttqh
         QBzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 1 Feb 2018 10:27:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jolly Shah <JOLLYS@xilinx.com>
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rajan Vaja <RAJANV@xilinx.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Message-ID: <20180201102730.33q4xrjw3vhrgk4i@lakrids.cambridge.arm.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
 <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
 <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517943929452186?=
X-GMAIL-MSGID: =?utf-8?q?1591194020290342277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 01:04:45AM +0000, Jolly Shah wrote:
> > > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > > +
> > > +The zynqmp-firmware node describes the interface to platform firmware.
> > 
> > Is there any documentation for this that can be referred to?
> >
> 
> Will add more information about supported APIs in next version patch.
> Below document describes interface APIs though it is not latest.   
> https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Thanks for the link.

It might be better for the compatible string to be "xlnx,zynqmp-eemi",
to make it clear which firmware interfaces are being described, assuming
that this being is only intended to cover EEMI.

Thanks,
Mark.
