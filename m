Return-Path: <robherring2@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2052289-1522103020-2-12499489904529604973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25,
  FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.194', Host='mail-ot0-f194.google.com', Country='US',
  FromHeader='org', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: robherring2@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522103019; b=eYH5Nlh3ontHBEKdvV6U+MPWkmgTMhAqz2xfLJh/njspfvy
    jxeFsE2+nmOjLR6/cZGxlupArhO1gwIFP3N4sLZXiKIGH1iHB4RGja7O54hbRMjW
    IKn7lMTBlOADw55Vc2LybvhbMlYkutMvZOn4m7jcd33l0DO6A5iiNQwgnI2OC1Gf
    3wLT2rRNMYesYbT6uQaPvHyUY3tCm+NlSEltJFLt7dKkp8rVRUQyqlzN6p6ExA9Y
    csdKN55Evf1wX4QRycg8F2VZWuzdPRv+EiXNJHW8dYju23YIpSR+sErpry4IjNdV
    zu0/HF//7vDdzScmVN3HvGSNN6Pw+CfwuDavHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1522103019; bh=XCkS6Py7EGgKWz0Mvr/j9IrVrmqUEApqSW59h7rnLNI=; b=h
    wTVlJJML+h6tbQivi2zIjgQYhvtsXmcJzAPAM91web3roqOw6eGIFqzYz4Nv3UqD
    PJ53n/lRvP67cqiI+Q2d1lWGRYef+a9XLz5UTyoI3hagxbShXivZcjPEXXZbLvwN
    kfkBfo8HhFOdcJKA9UtjUkg5p+lof5Yi6iIzyhTfFzHbsqBmD6KHmgl91iS0EDKk
    bjNrRYuk4ZOGeuJC0PaS9QM5YLeSNClFNJqizVXEgheYds9fxIKCZpSdNOmbX4SS
    KmQyXyFqMXM1Bttc6qIvDpyBj80pPGBUuuQGIJZHswagUrNDHQYAsgO0wzKXSn5i
    iDfxQDuBfeLVAND4bKQVw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=74.125.82.194 (mail-ot0-f194.google.com);
    spf=pass smtp.mailfrom=robherring2@gmail.com smtp.helo=mail-ot0-f194.google.com;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Qqoq6JbO;
    x-ptr=pass x-ptr-helo=mail-ot0-f194.google.com x-ptr-lookup=mail-ot0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=74.125.82.194 (mail-ot0-f194.google.com);
    spf=pass smtp.mailfrom=robherring2@gmail.com smtp.helo=mail-ot0-f194.google.com;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Qqoq6JbO;
    x-ptr=pass x-ptr-helo=mail-ot0-f194.google.com x-ptr-lookup=mail-ot0-f194.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOeF9r65ZbICLiUN0daRY7uObKeQ7NCrt86TOIAAVl5zjqQaeCpqT8nekc+6COtUCkJ8YksU/hey6e+yefyzB44XamkfoWc982MWjvD2iHuWJUFIcMH5
    BIZo+5lZd3MZk/fpk+s7O3VDzeoW/EZpPHJghkVRF7ynCZyLecNJy9tGZhj+ZKBha4Z54quyNtLjWc8Jwqu98rohU533yHKAn2E=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=yE5ZjUksA4vri4vDMzzbfg==:117
    a=S9Yh29hGjA0mksVP5FvCIw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=l0hiEBf7AAAA:8 a=0ESQRAHoJt8znWtCboQA:9 a=uVdBq7LhVzjmgFZS:21
    a=_fB07isOL6S--Oym:21 a=CjuIK1q_8ugA:10 a=ynCB8LqupOr-u-Kv-6Up:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AG47ELs05XwIYv81fUvGPhogjtk8CIcvR6OjXqho96peQWNOGW/UFfBrBPKRGfiwnVVK7E1COe7Sqw==
Date: Mon, 26 Mar 2018 17:23:36 -0500
From: Rob Herring <robh@kernel.org>
To: ShuFan Lee <leechu729@gmail.com>
Cc: greg@kroah.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net,
	mark.rutland@arm.com, shufan_lee@richtek.com, cy_huang@richtek.com,
	jun.li@nxp.com, mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: rt1711h device tree binding
 document
Message-ID: <20180326222336.jqix6k4pyqy4bg36@rob-hp-laptop>
References: <1521537304-7531-1-git-send-email-leechu729@gmail.com>
 <1521537304-7531-3-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521537304-7531-3-git-send-email-leechu729@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 05:15:04PM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Add device tree binding document for Richtek RT1711H Type-C chip driver
> 
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
> ---
>  .../devicetree/bindings/usb/richtek,rt1711h.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> 
>  changelogs between v2 & v3
>  - add dt-bindings for rt1711h typec driver
> 
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> new file mode 100644
> index 000000000000..7da4dac78ea7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> @@ -0,0 +1,30 @@
> +Richtek RT1711H TypeC PD Controller.
> +
> +Required properties:
> + - compatible : Must be "richtek,rt1711h".
> + - reg : Must be 0x4e, it's slave address of RT1711H.
> +
> +Recommended properties :
> + - interrupt-parent : the phandle for the interrupt controller that
> +   provides interrupts for this device.
> + - interrupts : <a b> where a is the interrupt number and b represents an
> +   encoding of the sense and level information for the interrupt.
> +
> +Optional properties :
> + - rt,intr-gpios : IRQ GPIO pin that's connected to RT1711H interrupt.
> +   if interrupt-parent & interrupts are not defined, use this property instead.

Drop this. You should simply always have interrupts property.

Rob
