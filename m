Return-Path: <hverkuil@xs4all.nl>
X-Google-Smtp-Source: AB8JxZrrBrdorsY+cOm3bB/kqWCNXIRxWLxc0evsv3ylOsCo9OJpPH7Y2Xkdh4pk0wBlib5wyARH
ARC-Seal: i=1; a=rsa-sha256; t=1525701031; cv=none;
        d=google.com; s=arc-20160816;
        b=haLiVLBcNH/1jKC0uFHFsg8hhfjNEJPVAQyUOXTzqu5ZXeeD7Wg3/478XyX/ovO9i8
         c+0hysgwffk7NlQ/lnPKrHgb0xUweT2Yv58qGGX8KFG9ZOnBhOi9I9M7sBWtVLhlNXex
         fAJn5eCdb7syxYOZIkryb4K9F/NNnku5wvUGxrdHIFxnq3PS9Dn1YRz4JPS28FTin8kl
         j49uIT8kDvi0Qo0WYXJk2vBTSNokVpBQUU9hXIrok0Fm9UOJ5JhH1MZ4J9MhaWh2p5x9
         K3gcroKQV7QP/bqVxn7aEXHi9v+SMAM/khGFWdDm1fpvc4X0d2ovqn0nLvJdWnWAiKAY
         votQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=TSpWKSb0ycPYc/JpMcc5KOUJWGMQZb/HC/FO64VKW+8=;
        b=UQIEO36QZ5gfBChaYIfFxgitvYlklISrbhwcJ3q+QoEUVB8wjhwDiT+SHTYZ/EGUs5
         1ncw6RuCZ9AgP6RgDIxhy84gaoy2+tnhxmyP158WRArKaOCgKe32DY3SmLdCgGSKLn29
         5/6d5aoMkWPnJSxhOod6Romjpyk0q3VBaOjIcQ7cAG4dQXd7OKT5aMyB1vB60UKqF9eY
         iqb5NOtOWOkqNoSagWfmMPA2QUqneV/zcW/O4iGo6Ylym2jafBKmriVoJnSvypRAIOcj
         VgDtrqdQxyJt/Z2f+alDXBQ7qDRo1XiOwkQU7Jm9BYI+vYOmnAXpoAVLCcMnXm4AtjMF
         MDrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.26 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.26 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Subject: Re: [PATCH v3 09/14] media: v4l: Add definition for Allwinner's
 MB32-tiled NV12 format
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@st.com>, Thomas Gleixner
 <tglx@linutronix.de>, Hugues Fruchet <hugues.fruchet@st.com>,
 Alexandre Courbot <gnurou@gmail.com>,
 Florent Revest <florent.revest@free-electrons.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
 Smitha T Murthy <smitha.t@samsung.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Randy Li <ayaka@soulik.info>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-10-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <8b9aa08f-d514-5680-3d10-91e1a72c1e82@xs4all.nl>
Date: Mon, 7 May 2018 15:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507124500.20434-10-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNJGN3wMGbWheSry6ubSj8XV8r3xCg+2o91Q2tND6B5Le9Xrl1d9rgX4orqpTcm3lYdyyudbDdpRNX/eQkWwEtwQaAZL6JuntHU9+X5ikbNP9WW096Sk
 guwnRGmnnuQ4sLNILpC3smOKiCwg1QtAql7s8ZhlW8XMrKTyy5iRYiNlrl8AwN4Hk6ZQ9pGLl769/kn/8tF8At9f1OnWNB0ongjyvf/qs84peanzynXbs4v1
 YOD9Z8kdlm0bbdYvn9fIemell/IZ1FhLPTIXHzvL7X3/zibCft8lGRHQiWuEloTu8iTGbrWbq9izazrzRIXO1iAMKBWgIO7iRRWQPZBwIo5uzw3okqAOocrE
 roSEJhOwyRKBoVoj6Gnol0f9zBF2XzKjhKoUwOYGHaX86FDN/PHNTWcXsyJllX4DlndKdzhQuouITdiwYr/yYrOyd32DbKRirtBuJZ6LX6Ae4rGUxakM7U+i
 cIt5B1F7hfwY/NNZeUltqFfv4oyaLW9akUGia00A8+PsQZmY4zOPaUhMFljbIitSbiDgRobiGZCtR9tmLYt7/1GdDesv6iPYylSaw5zrnTmHiEbp7xZWUZCV
 TRxHC+lV1vWye5CH/HMx2xeapXKs/b5AZpDPikyVA3qCz+fdO0g57O1gCn2OfFEoAC0k4jP5iE8ufbvsek2w8gs1ixQEt3gI4muFQIdn/uQbm5TXSNaAJY3e
 I1/4OicKlaCqVNh4pFhYhs0rp0IuS7pKIRpNC9v6xxGBlpeL+tHaDGRX2tN10pCa3wko6NZzOwx6E8qfczQhJEMO0cVOmi+YJohe17j8eua3zgtjS5ObUMaY
 CheSYHtFQrmX8vUD5zUlfcQRLu2U5eFJbCcqKjcOuON7pr5zzoS+xyLdKnaMdwdDhR+85vU4K671ck4x1RbDsp2fx0h+Zv1YADkch7Lu9Zw9G25X1I6iedDt
 vI6uE6Lfzawnp5gqdUNAzcc0A3MP/ey86l75QzkVYjfXSabIwyYlTrSF2OTrl8Qc6ynWuidenkkuv4jm1bFMnFLsWmYEWxESnVLtPiPchUDehj49csQ/WxQP
 dKWfh4Nek6JvoZZozlY0Xya/S00+7ado/w7s1lWGBu7ceADgyNG4xQdOAKAG5GNzRhAlaKgl1Dpnl2ML+q5JLc0GU+vZUYWe6A/5Z0mgtq6+V32CPANO+Y3t
 R6FaQx8HEGdKH65eEgM1Pqz2TAKndI2xvkFwzj/cyaVClkiawelpSSGwloYcUam0yFbmy7qMkNcZwgvMqwDU+FYlgX+WMjdFmvs9VwXTmnuMupaYNhNwPvHJ
 j66ypQc5YgjG9FTHr3aF7PLwOhIdDpc8ygLPQXTTxfILCEdrMt/N4eLSZ2/wXkCueGatFPuF8XalzfpzbIKb4m9Zl141zWumP43iD6NRh8w7un0e7XlPvHnw
 VLqqKMC7Y7aEzMlSbAUkYAfdrmLEf5LAPJ2fnQcJgt+yTbSGKrhqxuxrW5jepJLA6B9S3vurgyXtaG3xMQKkGzs9tm9Wu+nVE1ay5hX0yU0FwaV4Z7gc5zsE
 AAM0XUZyg/IIgArxRI3ZRs5QUe38i7VDdHFZEppBUsdb5Gt4aE2TVm9pcnwBR9ZDYeDQtCCFOmgZCywGR2yaha3K
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809525524337659?=
X-GMAIL-MSGID: =?utf-8?q?1599813484630987261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/05/18 14:44, Paul Kocialkowski wrote:
> This introduces support for Allwinner's MB32-tiled NV12 format, where
> each plane is divided into macroblocks of 32x32 pixels. Hence, the size
> of each plane has to be aligned to 32 bytes. The pixels inside each
> macroblock are coded as they would be if the macroblock was a single
> plane, line after line.
> 
> The MB32-tiled NV12 format is used by the video engine on Allwinner
> platforms: it is the default format for decoded frames (and the only one
> available in the oldest supported platforms).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  include/uapi/linux/videodev2.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index d8f9b59d90d7..242a6bfa1440 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -670,6 +670,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
>  #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
> +#define V4L2_PIX_FMT_MB32_NV12 v4l2_fourcc('M', 'N', '1', '2') /* Allwinner NV12 in 32x32 macroblocks */

Must be documented in the spec as well.

Regards,

	Hans

>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
> 
